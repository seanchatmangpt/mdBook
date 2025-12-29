#!/bin/bash
# PostToolUse Hook: Format files after editing
# Runs after Edit or Write operations on Rust files

set -e

# Read input JSON from stdin
INPUT=$(cat)

# Extract file path from input
FILE_PATH=$(echo "$INPUT" | jq -r '.input.file_path // .input.path // empty' 2>/dev/null || echo "")

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

# Get project directory
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Format Rust files
if [[ "$FILE_PATH" == *.rs ]]; then
    if command -v rustfmt &> /dev/null; then
        # Only format if the file exists and is within the project
        if [ -f "$FILE_PATH" ]; then
            rustfmt "$FILE_PATH" 2>/dev/null || true
        fi
    fi
fi

# Format TOML files (Cargo.toml)
if [[ "$FILE_PATH" == *.toml ]]; then
    if command -v taplo &> /dev/null; then
        taplo format "$FILE_PATH" 2>/dev/null || true
    fi
fi

# Format JavaScript files
if [[ "$FILE_PATH" == *.js ]]; then
    if [ -f "$PROJECT_DIR/node_modules/.bin/eslint" ]; then
        "$PROJECT_DIR/node_modules/.bin/eslint" --fix "$FILE_PATH" 2>/dev/null || true
    fi
fi

exit 0
