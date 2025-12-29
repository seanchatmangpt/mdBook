# CLAUDE.md - AI Assistant Guide for mdBook

This document provides essential information for AI assistants working with the mdBook codebase.

## Project Overview

mdBook is a Rust utility to create modern online books from Markdown files. It's maintained by the Rust project and is widely used for Rust documentation including "The Rust Programming Language" book.

- **Repository**: https://github.com/rust-lang/mdBook
- **Documentation**: https://rust-lang.github.io/mdBook/
- **License**: Mozilla Public License v2.0
- **Minimum Rust Version**: 1.88.0 (Rust Edition 2024)

## Codebase Structure

```
mdBook/
├── src/                    # CLI binary entry point
│   ├── main.rs            # Main CLI application
│   └── cmd/               # CLI subcommands (init, build, serve, watch, test, clean)
├── crates/                # Workspace crates
│   ├── mdbook-core/       # Shared types and utilities (internal)
│   ├── mdbook-driver/     # High-level API for running mdBook (public, semver stable)
│   ├── mdbook-html/       # HTML renderer (internal)
│   ├── mdbook-markdown/   # Markdown processing (public, semver stable)
│   ├── mdbook-preprocessor/ # Preprocessor framework (public, semver stable)
│   ├── mdbook-renderer/   # Renderer framework (public, semver stable)
│   ├── mdbook-summary/    # SUMMARY.md parser (public, semver stable)
│   ├── mdbook-compare/    # Development utility for comparing outputs
│   └── xtask/             # Development task automation
├── tests/
│   ├── testsuite/         # Main integration test suite
│   └── gui/               # Browser-based GUI tests (.goml files)
├── guide/                 # mdBook user guide (dogfooding)
├── examples/              # Example preprocessors and usage
└── ci/                    # CI helper scripts
```

### Crate Purposes

| Crate | Stability | Purpose |
|-------|-----------|---------|
| `mdbook-driver` | Semver stable | High-level API: `MDBook`, `BookBuilder` for managing/rendering books |
| `mdbook-preprocessor` | Semver stable | Framework for building custom preprocessors |
| `mdbook-renderer` | Semver stable | Framework for building custom renderers/backends |
| `mdbook-summary` | Semver stable | Parses `SUMMARY.md` book structure |
| `mdbook-markdown` | Semver stable | Markdown processing utilities |
| `mdbook-core` | Internal | Shared types, config, utilities (may change without warning) |
| `mdbook-html` | Internal | HTML renderer implementation |

## Development Commands

### Building

```bash
cargo build                    # Debug build
cargo build --release          # Release build
```

### Testing

```bash
# Run all tests (recommended before PR)
cargo xtask test-all

# Individual test commands
cargo test --workspace                     # Unit and integration tests
cargo test --workspace --no-default-features  # Test without default features
cargo test --test gui                      # GUI browser tests (requires npm)
cargo clippy --workspace --all-targets --no-deps -- -D warnings
cargo fmt --check                          # Format check
cargo +stable semver-checks               # SemVer compatibility check
RUSTDOCFLAGS="-D warnings" cargo doc --workspace --document-private-items --no-deps

# Run specific tests
cargo test --test gui -- search           # Filter GUI tests by name
cargo test --test gui -- --disable-headless-test  # Run with visible browser
```

### JavaScript Linting

```bash
npm install      # First time setup
npm run lint     # Run eslint on .js files
```

### xtask Commands

```bash
cargo xtask test-all           # Run all CI checks
cargo xtask test-workspace     # Workspace tests only
cargo xtask clippy             # Clippy check
cargo xtask doc                # Documentation check
cargo xtask eslint             # JavaScript linting
cargo xtask fmt                # Format check
cargo xtask gui                # GUI tests
cargo xtask semver-checks      # SemVer check
cargo xtask bump <BUMP>        # Bump version (patch, alpha, etc.)
cargo xtask changelog          # Generate changelog entries
```

## Testing Conventions

### Test Structure

Tests use the `snapbox` crate for snapshot testing:
- `str![[...]]` - Inline expected content (auto-updated with `SNAPSHOTS=overwrite`)
- `file!("path")` - External file expected content
- Wildcards: `...` (any lines), `[..]` (any chars on line)

### BookTest Framework

Integration tests use `BookTest` for setting up temporary book directories:

```rust
BookTest::from_dir("theme/mytest")
    .build()
    .check_main_file("book/index.html", str![["expected content"]])
    .change_file("src/index.md", "new contents")
    .build()
    .check_main_file("book/index.html", str![["new contents"]]);
```

### GUI Tests

Located in `tests/gui/` using `.goml` files (browser-UI-test framework):
- Test books in `tests/gui/books/`
- Requires `npm install` for `browser-ui-test` package

## Code Quality Standards

### Formatting

- Use `cargo fmt` (rustfmt style edition 2024)
- Run before all PRs

### Linting

- Clippy warnings must pass: `cargo clippy -- -D warnings`
- Workspace lints configured in root `Cargo.toml`:
  - `missing_docs = "warn"`
  - `rust_2018_idioms = "warn"`
  - `unreachable_pub = "warn"`

### Documentation

- Almost all Rust items should have doc comments
- API documentation must not have warnings (`RUSTDOCFLAGS="-D warnings"`)
- User guide updates required for user-facing changes

## Key Conventions

### API Stability

- Breaking API changes only in major SemVer releases (very infrequent)
- CLI interface is considered stable
- Public crates (`-driver`, `-preprocessor`, `-renderer`, `-summary`, `-markdown`) follow semver
- Internal crates (`-core`, `-html`) may change without warning

### Feature Flags

Default features: `watch`, `serve`, `search`

```toml
[features]
watch = ["dep:notify", "dep:notify-debouncer-mini", "dep:ignore", "dep:pathdiff", "dep:walkdir"]
serve = ["dep:futures-util", "dep:tokio", "dep:axum", "dep:tower-http"]
search = ["mdbook-html/search"]
```

### Environment Variables

- `MDBOOK_LOG` - Logging level (uses tracing, defaults to INFO)

### Adding New Dependencies

Dependencies defined in workspace `[workspace.dependencies]` section in root `Cargo.toml`.

## Browser Compatibility

Support Chrome, Safari, Firefox, Edge on:
- Windows, macOS, Linux, iOS, Android
- Keep compatible with relatively recent browser versions

## Issue Labels

- `A-*` - Area (JavaScript, Style, HTML, Mobile)
- `E-*` - Experience level (E-Easy for beginners)
- `E-Help-wanted` / `Feature accepted` - Ready for external contribution
- `S-*` - Status
- `C-*` - Category
- `M-*` - Meta/management

## Contributing Checklist

1. Check for existing issue or create one first
2. Claim issue with `@rustbot claim`
3. Almost all changes need tests
4. Documentation updates for user-facing changes
5. Run `cargo xtask test-all` before submitting PR
6. Follow existing code patterns and style

## Updating highlight.js

See detailed instructions in CONTRIBUTING.md for updating the syntax highlighting library.

## Release Process (Maintainers)

1. Create version bump PR: `cargo xtask bump <BUMP>`
2. Update changelog: `cargo xtask changelog`
3. After merge, create GitHub release

## Quick Reference

| Task | Command |
|------|---------|
| Build | `cargo build` |
| Test all | `cargo xtask test-all` |
| Unit tests | `cargo test --workspace` |
| GUI tests | `cargo test --test gui` |
| Format | `cargo fmt` |
| Lint Rust | `cargo clippy` |
| Lint JS | `npm run lint` |
| Docs | `cargo doc --workspace` |
| SemVer check | `cargo +stable semver-checks` |
