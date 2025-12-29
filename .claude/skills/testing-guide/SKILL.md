---
name: testing-guide
description: Expert testing guidance for mdBook. Use when writing tests, debugging test failures, using the BookTest framework, or working with snapshot testing using snapbox.
allowed-tools: ["Read", "Bash", "Grep", "Glob"]
---

# Testing Guide Skill for mdBook

You are an expert in testing the mdBook codebase.

## Test Structure

### Directory Layout
```
tests/
├── testsuite/           # Main integration tests
│   ├── book_test.rs     # BookTest framework
│   ├── build.rs         # Build tests
│   ├── config.rs        # Configuration tests
│   └── ...
└── gui/                 # Browser GUI tests
    ├── books/           # Test book fixtures
    └── *.goml           # GUI test scripts
```

## BookTest Framework

### Basic Usage
```rust
use crate::book_test::BookTest;
use snapbox::str;

#[test]
fn basic_build() {
    BookTest::from_dir("build/basic")
        .build()
        .check_main_file("book/index.html", str![[r#"expected content"#]]);
}
```

### Chaining Operations
```rust
BookTest::from_dir("theme/mytest")
    .build()
    .check_main_file("book/index.html", str![["initial content"]])
    .change_file("src/index.md", "new contents")
    .build()
    .check_main_file("book/index.html", str![["new contents"]]);
```

## Snapbox Snapshot Testing

### Inline Snapshots
```rust
// Auto-update with SNAPSHOTS=overwrite
check_output(output, str![[r#"
    expected
    output
    here
"#]]);
```

### File Snapshots
```rust
check_file("output.txt", file!("expected/output.txt"));
```

### Wildcards
- `...` - Match any lines
- `[..]` - Match any characters on a line
- `[EXE]` - Match executable extension

### Updating Snapshots
```bash
SNAPSHOTS=overwrite cargo test
```

## GUI Tests

### Running
```bash
cargo test --test gui              # All GUI tests
cargo test --test gui -- search    # Filter by name
cargo test --test gui -- --disable-headless-test  # Visible browser
```

### GOML Syntax
```goml
go-to: "file://" + |CURRENT_DIR| + "/book/index.html"
assert-text: (".chapter", "Expected Title")
click: "#search-toggle"
wait-for: "#searchbar"
```

## Test Commands

```bash
# Full test suite
cargo xtask test-all

# Unit tests only
cargo test --workspace

# Without default features
cargo test --workspace --no-default-features

# Specific test
cargo test test_name

# With output
cargo test test_name -- --nocapture
```

## Best Practices
1. Create fixtures in appropriate `testsuite/*/` directories
2. Use `str![[]]` for expected content (auto-updatable)
3. Test both success and failure cases
4. Keep test books minimal
5. Use descriptive test names
