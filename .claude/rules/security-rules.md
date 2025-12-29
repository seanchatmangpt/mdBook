---
paths:
  - "**/*.rs"
  - "**/*.js"
  - "**/*.html"
  - "**/*.hbs"
---

# Security Rules for mdBook

## Input Validation

### Path Handling
- Always validate paths before file operations
- Check for path traversal (`..`)
- Use `canonicalize()` to resolve symlinks
- Verify paths are within expected directories

```rust
// Good
fn read_chapter(book_root: &Path, chapter: &str) -> Result<String> {
    let path = book_root.join(chapter).canonicalize()?;
    if !path.starts_with(book_root) {
        return Err(anyhow!("Path traversal detected"));
    }
    std::fs::read_to_string(path)
}
```

### User Input
- Never trust user input from book.toml
- Validate URLs before including in HTML
- Escape HTML entities in user content

## HTML/JavaScript Security

### XSS Prevention
- Use Handlebars auto-escaping (default)
- Only use `{{{triple-braces}}}` when content is trusted
- Validate and sanitize URLs in links

### Content Security
- No `eval()` or `new Function()`
- No inline event handlers with dynamic data
- Use `textContent` instead of `innerHTML` when possible

## Command Execution

### Shell Commands
- Never pass unsanitized input to shell commands
- Use `Command::new()` with explicit arguments
- Avoid shell interpolation

```rust
// Good
Command::new("git")
    .arg("status")
    .arg("--porcelain")
    .output()?;

// Bad - shell injection risk
let cmd = format!("git status {}", user_input);
std::process::Command::new("sh")
    .arg("-c")
    .arg(cmd)
    .output()?;
```

## Sensitive Data

### Never Commit
- API keys or tokens
- Private keys
- Passwords or secrets
- Personal information

### Logging
- Don't log sensitive data
- Be careful with error messages exposing paths
- Use `tracing` with appropriate log levels

## Dependencies

### Review Before Adding
- Check crate maintenance status
- Review security advisories
- Prefer well-maintained crates
- Minimize dependency count

### Keep Updated
- Run `cargo audit` periodically
- Update dependencies for security fixes
- Test after updates
