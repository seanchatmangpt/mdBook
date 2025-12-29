---
description: Run all CI checks including tests, clippy, formatting, and documentation
allowed-tools: Bash(cargo:*), Bash(npm:*)
---

Run the complete test suite for mdBook using `cargo xtask test-all`.

This includes:
1. `cargo test --workspace` - Unit and integration tests
2. `cargo test --workspace --no-default-features` - Test without default features
3. `cargo clippy --workspace --all-targets --no-deps -- -D warnings` - Lint checks
4. `cargo fmt --check` - Format verification
5. `RUSTDOCFLAGS="-D warnings" cargo doc --workspace --document-private-items --no-deps` - Doc checks
6. `npm run lint` - JavaScript linting (if npm is available)

Report any failures with clear explanations of what went wrong and how to fix them.
