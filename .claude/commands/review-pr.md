---
description: Perform a comprehensive code review of a pull request
argument-hint: [pr_number or branch_name]
allowed-tools: Bash(git:*), Bash(gh:*), Read, Grep, Glob
---

Review pull request: $ARGUMENTS

Evaluate the following aspects:

## Code Quality
- Code clarity and readability
- Proper error handling
- No security vulnerabilities (command injection, XSS, etc.)
- Follows existing code patterns and style

## Testing
- Adequate test coverage for changes
- Tests are meaningful and well-structured
- Edge cases are covered

## Documentation
- Doc comments for public APIs
- User guide updates if user-facing
- CHANGELOG entry if needed

## mdBook Specifics
- SemVer compatibility (use `cargo semver-checks` if breaking changes suspected)
- Browser compatibility considerations for JS/HTML changes
- Performance implications

Provide structured feedback with:
- Summary of changes
- Issues found (with severity: critical/high/medium/low)
- Suggestions for improvement
- Overall recommendation (approve/request changes)
