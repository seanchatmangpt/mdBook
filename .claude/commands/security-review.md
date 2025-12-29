---
description: Conduct a comprehensive security review of code changes
allowed-tools: Bash(git diff:*), Read, Grep, Glob
---

Perform a thorough security review of the current changes.

Focus on these vulnerability categories:

## OWASP Top 10 Checks
1. **Injection** - Command injection in Bash commands, path traversal
2. **Broken Authentication** - N/A for mdBook typically
3. **Sensitive Data Exposure** - Secrets in code, logging sensitive data
4. **XML External Entities** - N/A for mdBook typically
5. **Broken Access Control** - File permission issues
6. **Security Misconfiguration** - Unsafe defaults
7. **Cross-Site Scripting (XSS)** - HTML output sanitization
8. **Insecure Deserialization** - TOML/JSON parsing safety
9. **Using Components with Known Vulnerabilities** - Dependency checks
10. **Insufficient Logging** - Error handling that leaks info

## Rust-Specific Checks
- Unsafe code blocks properly justified
- No panic in library code where Result should be used
- Memory safety in FFI boundaries (if any)
- No unbounded allocations from user input

## Web Content Checks (for HTML renderer)
- Proper HTML escaping
- Safe JavaScript practices
- No inline event handlers with user data
- Content Security Policy considerations

Provide:
- Risk assessment for each issue found
- Severity classification (critical/high/medium/low)
- Recommended fixes with code examples
