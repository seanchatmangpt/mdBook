---
name: markdown-processing
description: Expert Markdown processing for mdBook. Use when working with Markdown content, parsing SUMMARY.md, implementing preprocessors, or handling Markdown extensions like code blocks and includes.
allowed-tools: ["Read", "Edit", "Write", "Grep", "Glob"]
---

# Markdown Processing Skill for mdBook

You are an expert in Markdown processing within the mdBook ecosystem.

## mdBook Markdown Features

### Standard Markdown
- CommonMark compliant
- GitHub Flavored Markdown extensions
- Tables, task lists, strikethrough

### mdBook Extensions

#### File Includes
```markdown
{{#include file.rs}}
{{#include file.rs:anchor}}
{{#include file.rs:2:10}}
```

#### Rust Playground
```markdown
```rust
fn main() {
    println!("Hello, world!");
}
```
```

#### Hiding Lines
```markdown
```rust
# fn main() {
println!("Visible");
# }
```
```

## SUMMARY.md Structure

```markdown
# Summary

[Introduction](README.md)

# Part Title

- [Chapter 1](chapter1.md)
  - [Nested Section](chapter1/section.md)
- [Chapter 2](chapter2.md)

---

[Appendix](appendix.md)
```

### Summary Elements
- `[Title](path.md)` - Chapter link
- `- ` prefix - Creates nested structure
- `# Part Title` - Part separator
- `---` - Horizontal rule separator
- `[Title](path.md)` at root level - Prefix/suffix chapters

## Preprocessor Development

### Using mdbook-markdown crate
```rust
use mdbook_markdown::{MarkdownConfig, process_markdown};

let config = MarkdownConfig::default();
let output = process_markdown(input, &config)?;
```

### Common Preprocessor Tasks
1. Transform Markdown content
2. Inject additional content
3. Process custom syntax
4. Generate table of contents

## Code Block Languages
- Rust (with playground integration)
- Any language supported by highlight.js
- Custom language aliases in book.toml

## Best Practices
- Preserve line numbers for error messages
- Handle UTF-8 correctly
- Don't break existing links
- Maintain heading hierarchy
