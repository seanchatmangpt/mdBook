---
name: rust-development
description: Expert Rust development assistance for mdBook. Use when writing Rust code, fixing compiler errors, implementing traits, or working with Cargo workspaces. Applies Rust best practices and idiomatic patterns.
allowed-tools: ["Read", "Edit", "Write", "Bash", "Grep", "Glob"]
---

# Rust Development Skill for mdBook

You are an expert Rust developer specializing in the mdBook codebase.

## Rust Best Practices

### Error Handling
- Use `Result<T, E>` for fallible operations
- Use `anyhow` for application-level errors (used throughout mdBook)
- Implement `Display` for custom error types
- Avoid `.unwrap()` in library code; use `?` operator

### Memory and Performance
- Prefer borrowing over cloning
- Use `Cow<str>` for strings that may or may not need allocation
- Avoid unnecessary allocations in hot paths
- Use iterators instead of collecting into intermediate vectors

### API Design
- Follow the [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- Make types non-exhaustive with `#[non_exhaustive]` for future compatibility
- Use builder patterns for complex constructors
- Document all public items with doc comments

### mdBook-Specific Patterns
- Workspace crates are in `crates/` directory
- Public crates follow semver strictly
- Internal crates (`-core`, `-html`) can change freely
- Use `tracing` for logging (not `log` or `println!`)

## Code Style

```rust
// Prefer this:
fn process_chapter(chapter: &Chapter) -> Result<String> {
    let content = chapter.content.as_ref()
        .ok_or_else(|| anyhow!("No content"))?;
    Ok(process_markdown(content))
}

// Not this:
fn process_chapter(chapter: &Chapter) -> String {
    chapter.content.as_ref().unwrap().clone()
}
```

## Common Patterns in mdBook

### Working with Books
```rust
use mdbook_driver::MDBook;

let book = MDBook::load("path/to/book")?;
book.build()?;
```

### Preprocessors
```rust
use mdbook_preprocessor::{Preprocessor, PreprocessorContext};

impl Preprocessor for MyPreprocessor {
    fn run(&self, ctx: &PreprocessorContext, book: Book) -> Result<Book> {
        // Process book
        Ok(book)
    }
}
```

## Linting Requirements
- No clippy warnings: `cargo clippy -- -D warnings`
- Format with `cargo fmt`
- All public items need doc comments
- Use `rust_2018_idioms`
