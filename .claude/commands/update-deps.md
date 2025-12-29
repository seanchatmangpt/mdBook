---
description: Update dependencies and verify compatibility
allowed-tools: Bash(cargo:*), Read, Grep
---

Update project dependencies safely.

## Steps
1. Run `cargo update` to update Cargo.lock
2. Check for any breaking changes in updated crates
3. Run `cargo xtask test-all` to verify everything works
4. Review the diff in Cargo.lock

## Checks
- Verify no SemVer-incompatible updates for public dependencies
- Check for security advisories with `cargo audit` (if installed)
- Ensure minimum Rust version is still supported

## Special Considerations for mdBook
- `pulldown-cmark` is part of the public API - be careful with updates
- Check browser compatibility for any JS dependency updates
- Verify highlight.js compatibility if updated

Report:
- Which dependencies were updated
- Any breaking changes detected
- Test results
- Recommendations for manual review
