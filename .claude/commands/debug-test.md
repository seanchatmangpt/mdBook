---
description: Debug a failing test and find the root cause
argument-hint: [test_name or pattern]
allowed-tools: Bash(cargo test:*), Read, Grep, Glob
---

Debug the failing test: $ARGUMENTS

## Investigation Steps
1. Run the test with `cargo test $ARGUMENTS -- --nocapture` to see output
2. Identify the assertion that's failing
3. Trace back through the code to understand expected vs actual behavior
4. Check recent changes that might have caused the regression
5. Examine related tests for context

## Analysis
- What is the test trying to verify?
- What is the expected behavior?
- What is the actual behavior?
- Why is there a discrepancy?

## Root Cause
Identify and explain:
- The root cause of the failure
- Whether it's a test bug or implementation bug
- The fix required

## Verification
After identifying the issue, suggest:
- The specific code change needed
- How to verify the fix
- Any additional tests to prevent regression
