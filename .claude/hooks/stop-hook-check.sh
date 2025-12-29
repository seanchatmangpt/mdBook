#!/bin/bash
# Stop Hook: Run checks when Claude Code session ends
# Provides final validation and reminders

set -e

# Get project directory
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Check for uncommitted changes
if command -v git &> /dev/null; then
    cd "$PROJECT_DIR"

    # Check if in a git repo
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        # Get status
        CHANGES=$(git status --porcelain 2>/dev/null | wc -l)

        if [ "$CHANGES" -gt 0 ]; then
            echo "Note: $CHANGES uncommitted change(s) in the repository"
            echo "Consider committing your changes before ending the session."
        fi

        # Check for staged but uncommitted changes
        STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l)
        if [ "$STAGED" -gt 0 ]; then
            echo "Warning: $STAGED file(s) staged but not committed"
        fi
    fi
fi

# Remind about tests if Rust files were modified
if command -v git &> /dev/null; then
    cd "$PROJECT_DIR"
    RUST_CHANGES=$(git diff --name-only HEAD 2>/dev/null | grep -c '\.rs$' || echo "0")
    if [ "$RUST_CHANGES" -gt 0 ]; then
        echo "Tip: Rust files were modified. Consider running 'cargo xtask test-all'"
    fi
fi

exit 0
