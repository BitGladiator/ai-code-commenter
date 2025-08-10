#!/bin/bash

# Load API key from .env
source ../.env

if [[ -z "$OPENROUTER_API_KEY" ]]; then
  echo "Error: OPENROUTER_API_KEY not set in .env"
  exit 1
fi

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 path/to/codefile [model-name]"
  echo "Example: $0 ../input/sample_code.py openai/gpt-5-mini"
  exit 1
fi

INPUT_FILE=$1
MODEL=${2:-"openai/gpt-5-mini"} # default model if not provided

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: File '$INPUT_FILE' does not exist."
  exit 1
fi

# Determine output file path
BASENAME=$(basename "$INPUT_FILE")
OUTPUT_FILE="../output/commented_$BASENAME"

echo "Commenting code in $INPUT_FILE using model: $MODEL ..."
echo "---------------------------------------------"

# Read file content
CODE_CONTENT=$(<"$INPUT_FILE")

# Build JSON safely with jq (added max_tokens)
JSON_BODY=$(jq -n \
  --arg model "$MODEL" \
  --arg sys "You are a helpful assistant that comments code in detail, explaining line by line." \
  --arg user "Here is the code:\n$CODE_CONTENT" \
  '{
    model: $model,
    messages: [
      {role: "system", content: $sys},
      {role: "user", content: $user}
    ],
    temperature: 0.2,
    max_tokens: 3000
  }')

# Call OpenRouter API
RESPONSE=$(curl -s https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -d "$JSON_BODY")

# Extract generated text
COMMENTED_CODE=$(echo "$RESPONSE" | jq -r '.choices[0].message.content')

# Check if API returned something valid
if [[ "$COMMENTED_CODE" == "null" || -z "$COMMENTED_CODE" ]]; then
  echo "API did not return a valid response."
  echo "Raw response:"
  echo "$RESPONSE"
  exit 1
fi

# Save to output file
echo "$COMMENTED_CODE" > "$OUTPUT_FILE"
echo "Commented code saved to $OUTPUT_FILE"

