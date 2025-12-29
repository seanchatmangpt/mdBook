#!/bin/bash
# PreToolUse Hook: Validate file changes before they happen
# Runs before Edit or Write operations

set -e

# Read input JSON from stdin
INPUT=$(cat)

# Extract file path from input
FILE_PATH=$(echo "$INPUT" | jq -r '.input.file_path // .input.path // empty' 2>/dev/null || echo "")

if [ -z "$FILE_PATH" ]; then
    # No file path in input, allow the operation
    exit 0
fi

# Protect critical files from accidental modification
PROTECTED_FILES=(
    "Cargo.lock"
    ".git/"
    "LICENSE"
)

for protected in "${PROTECTED_FILES[@]}"; do
    if [[ "$FILE_PATH" == *"$protected"* ]]; then
        echo "Warning: Attempting to modify protected file: $FILE_PATH" >&2
        # Exit 0 to allow but warn; use exit 2 to block
        exit 0
    fi
done

# Check for sensitive patterns
if [[ "$FILE_PATH" =~ \.(env|secret|key|pem)$ ]]; then
    echo "Blocked: Cannot modify sensitive file: $FILE_PATH" >&2
    exit 2
fi

# All checks passed
exit 0
