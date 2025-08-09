#!/bin/bash

# Load API key from .env
source ../.env

if [[ -z "$OPENAI_API_KEY" ]]; then
  echo "Error: OPENAI_API_KEY not set in .env"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/codefile"
  exit 1
fi

INPUT_FILE=$1
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: File '$INPUT_FILE' does not exist."
  exit 1
fi

# Determine output file path
BASENAME=$(basename "$INPUT_FILE")
OUTPUT_FILE="../output/commented_$BASENAME"

echo "Commenting code in $INPUT_FILE ..."

