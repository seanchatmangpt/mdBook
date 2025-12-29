---
description: Analyze and fix a GitHub issue by implementing the solution
argument-hint: [issue_number]
allowed-tools: Bash(gh:*), Bash(git:*), Read, Grep, Glob, Edit, Write
---

Analyze and implement a fix for GitHub issue: $ARGUMENTS

Follow these steps:
1. Fetch issue details using `gh issue view $ARGUMENTS`
2. Understand the problem described in the issue
3. Search the codebase for relevant files using grep and glob
4. Identify the root cause of the issue
5. Implement the necessary changes to fix the issue
6. Add or update tests to cover the fix
7. Run `cargo test --workspace` to verify the fix
8. Create a descriptive commit message

After implementing the fix, summarize:
- What was the root cause
- What changes were made
- How the fix was verified
