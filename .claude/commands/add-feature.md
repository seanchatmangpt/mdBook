---
description: Plan and implement a new feature for mdBook
argument-hint: [feature_description]
allowed-tools: Read, Grep, Glob, Edit, Write, Bash(cargo:*), Bash(git:*)
---

Plan and implement the following feature: $ARGUMENTS

## Planning Phase
1. Understand the feature requirements
2. Identify which crates need modification
3. Check for existing similar functionality
4. Consider SemVer implications (breaking changes?)
5. Plan the implementation approach

## Implementation Phase
1. Implement the core functionality
2. Add comprehensive tests
3. Update documentation (doc comments, guide if user-facing)
4. Run `cargo xtask test-all` to verify

## Checklist
- [ ] Implementation follows existing code patterns
- [ ] Public APIs have doc comments
- [ ] Tests cover happy path and edge cases
- [ ] No clippy warnings
- [ ] Documentation updated
- [ ] CHANGELOG entry added (if applicable)

## Output
Provide:
- Summary of changes made
- Files modified
- Any design decisions and rationale
- Testing verification results
