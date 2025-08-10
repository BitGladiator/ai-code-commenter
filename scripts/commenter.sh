#!/bin/bash
set -euo pipefail

# Load API key from .env
source ../.env

if [[ -z "${OPENROUTER_API_KEY:-}" ]]; then
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

# Detect language from extension (for language tag in fenced code block)
EXT="${INPUT_FILE##*.}"
case "$EXT" in
  py) LANG="python" ;;
  sh|bash|zsh) LANG="bash" ;;
  js) LANG="javascript" ;;
  ts) LANG="typescript" ;;
  java) LANG="java" ;;
  c) LANG="c" ;;
  cpp|cc|cxx|hpp|hh) LANG="cpp" ;;
  go) LANG="go" ;;
  rs) LANG="rust" ;;
  php) LANG="php" ;;
  rb) LANG="ruby" ;;
  swift) LANG="swift" ;;
  kt|kts) LANG="kotlin" ;;
  sql) LANG="sql" ;;
  html) LANG="html" ;;
  css) LANG="css" ;;
  json) LANG="json" ;;
  yml|yaml) LANG="yaml" ;;
  md) LANG="markdown" ;;
  *) LANG="$EXT" ;;  # best-effort fallback
esac

# Build JSON safely with jq.
# NOTE: the system prompt forces the model to return ONLY a single fenced code block (no extra text).
JSON_BODY=$(jq -n \
  --arg model "$MODEL" \
  --arg sys "You are a helpful assistant that comments code in detail. **Important:** Return ONLY a single fenced code block (triple backticks) containing the full commented source code. Do NOT include any text outside the code block. Use the language tag matching: $LANG. Do not add explanations, notes, or lists outside the code block." \
  --arg user "Here is the code (do not modify semantics):\n$CODE_CONTENT\n\nTask: Add detailed line-by-line comments to the code. Preserve original lines and insert single-line comments explaining what the lines/blocks do. Use the standard single-line comment syntax for the language. Wrap the entire result in a single triple-backtick fenced block with the language tag (example: \`\`\`python). Do not include anything outside that single code fence." \
  --argjson max_tokens 3000 \
  '{
    model: $model,
    messages: [
      {role: "system", content: $sys},
      {role: "user", content: $user}
    ],
    temperature: 0.2,
    max_tokens: $max_tokens
  }')

# Call OpenRouter API
RESPONSE=$(curl -s https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -d "$JSON_BODY")

# Pull out the model text (raw)
RAW_OUTPUT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // ""')

# If the model returned a fenced code block, extract the first fenced block's contents.
# Otherwise, fall back to the raw output.
if echo "$RAW_OUTPUT" | grep -q '```'; then
  # Extract text between the first pair of ``` fences
  COMMENTED_CODE=$(echo "$RAW_OUTPUT" | awk 'BEGIN{inside=0} /^```/{ if (!inside) {inside=1; next} else {exit}} inside==1{print}')
  # If the first line inside the fence is the language tag (e.g., "python"), remove it.
  # Remove a single leading language tag line (like "python") if present.
  FIRST_LINE=$(echo "$COMMENTED_CODE" | sed -n '1p' || true)
  if [[ "$FIRST_LINE" =~ ^[a-zA-Z0-9_+-]+$ ]]; then
    # drop the first line
    COMMENTED_CODE=$(echo "$COMMENTED_CODE" | sed '1d')
  fi
else
  COMMENTED_CODE="$RAW_OUTPUT"
fi

# Final sanity check
if [[ -z "${COMMENTED_CODE//[[:space:]]/}" ]]; then
  echo "API did not return a valid commented-code block."
  echo "Raw response:"
  echo "$RESPONSE"
  exit 1
fi

# Save to output file
echo "$COMMENTED_CODE" > "$OUTPUT_FILE"
echo "Commented code saved to $OUTPUT_FILE"

