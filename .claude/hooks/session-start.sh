#!/bin/bash
# Session Start Hook for mdBook
# This script runs when a Claude Code session starts

set -e

# Get project directory
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Check Rust toolchain
if command -v rustc &> /dev/null; then
    RUST_VERSION=$(rustc --version)
    echo "Rust: $RUST_VERSION"
fi

# Check if Cargo.lock exists (indicates dependencies are set up)
if [ ! -f "$PROJECT_DIR/Cargo.lock" ]; then
    echo "Warning: Cargo.lock not found. Consider running 'cargo build' first."
fi

# Check minimum Rust version requirement
if [ -f "$PROJECT_DIR/Cargo.toml" ]; then
    MSRV=$(grep -oP '(?<=rust-version = ")[^"]+' "$PROJECT_DIR/Cargo.toml" 2>/dev/null || echo "unknown")
    if [ "$MSRV" != "unknown" ]; then
        echo "MSRV: $MSRV"
    fi
fi

# Set up environment variables if CLAUDE_ENV_FILE is provided
if [ -n "$CLAUDE_ENV_FILE" ]; then
    cat >> "$CLAUDE_ENV_FILE" << 'EOF'
export RUST_BACKTRACE=1
export MDBOOK_LOG=info
EOF
fi

# Check for node/npm (needed for GUI tests)
if command -v npm &> /dev/null; then
    if [ ! -d "$PROJECT_DIR/node_modules" ]; then
        echo "Note: Run 'npm install' for GUI tests and JS linting"
    fi
fi

exit 0
