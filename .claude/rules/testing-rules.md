---
paths:
  - "tests/**"
  - "**/*_test.rs"
  - "**/tests.rs"
---

# Testing Rules for mdBook

## Test Structure

### Use BookTest for Integration Tests
```rust
#[test]
fn my_feature_works() {
    BookTest::from_dir("feature/my-test")
        .build()
        .check_main_file("book/index.html", str![[r#"expected"#]]);
}
```

### Test Naming
- Use descriptive names: `test_build_with_custom_theme`
- Group related tests in modules
- Use `#[test]` attribute on each test function

## Snapbox Usage

### Inline Snapshots
```rust
// Use double brackets for multi-line content
str![[r#"
    expected
    content
"#]]
```

### Wildcards
- `...` - Match any number of lines
- `[..]` - Match any characters on a line
- `[EXE]` - Match executable extension (.exe on Windows)

### Updating Snapshots
```bash
SNAPSHOTS=overwrite cargo test test_name
```

## Test Data

### Directory Structure
```
tests/testsuite/
├── feature_name/
│   └── test_case/
│       ├── book.toml
│       └── src/
│           ├── SUMMARY.md
│           └── chapter.md
```

### Minimal Test Books
- Only include files needed for the test
- Use simple content
- Document what the test is verifying

## GUI Tests

### GOML Files
```goml
// Use clear selectors
go-to: "file://" + |CURRENT_DIR| + "/book/index.html"
assert-text: (".chapter-title", "Expected Title")
```

### Running GUI Tests
```bash
cargo test --test gui -- --disable-headless-test  # Debug mode
```

## Best Practices

1. Test both success and failure cases
2. Keep tests focused on one behavior
3. Use descriptive assertion messages
4. Clean up after tests (BookTest handles this automatically)
5. Don't test implementation details
