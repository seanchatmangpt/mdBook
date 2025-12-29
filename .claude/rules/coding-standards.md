---
paths:
  - "**/*.rs"
---

# Rust Coding Standards for mdBook

## Code Style

### Formatting
- Always run `cargo fmt` before committing
- Use rustfmt style edition 2024
- Maximum line length: 100 characters (soft limit)

### Naming Conventions
- Types: `PascalCase`
- Functions/methods: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`
- Modules: `snake_case`

### Imports
- Group imports: std, external crates, internal crates
- Use `use` statements at module top
- Prefer explicit imports over glob imports

## Error Handling

### Use Result for Fallible Operations
```rust
// Good
fn load_book(path: &Path) -> Result<Book> {
    let content = std::fs::read_to_string(path)?;
    parse_book(&content)
}

// Bad
fn load_book(path: &Path) -> Book {
    let content = std::fs::read_to_string(path).unwrap();
    parse_book(&content).unwrap()
}
```

### anyhow for Application Errors
- Use `anyhow::Result` for CLI and high-level operations
- Use `anyhow!()` macro for error creation
- Add context with `.context()` or `.with_context()`

## Documentation

### Required Documentation
- All public types, functions, and modules
- Non-obvious private functions
- Complex algorithms

### Doc Comment Style
```rust
/// Brief description of the function.
///
/// More detailed explanation if needed.
///
/// # Arguments
///
/// * `path` - The path to the book directory
///
/// # Returns
///
/// Returns the loaded book or an error if loading fails.
///
/// # Examples
///
/// ```
/// let book = load_book(Path::new("./my-book"))?;
/// ```
pub fn load_book(path: &Path) -> Result<Book> {
    // ...
}
```

## Linting

### Required Checks
- `cargo clippy -- -D warnings` must pass
- No `#[allow(clippy::...)]` without justification
- Address all `missing_docs` warnings

### Workspace Lints (from Cargo.toml)
- `missing_docs = "warn"`
- `rust_2018_idioms = "warn"`
- `unreachable_pub = "warn"`
