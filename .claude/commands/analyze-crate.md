---
description: Analyze a specific crate's architecture and design
argument-hint: [crate_name]
allowed-tools: Read, Grep, Glob
model: claude-opus-4-5-20251101
---

Analyze the architecture of the `$ARGUMENTS` crate in the mdBook workspace.

Provide comprehensive analysis including:

## Module Structure
- How is the crate organized?
- What are the main modules and their responsibilities?
- How do modules interact with each other?

## Public API
- What types and functions are exposed publicly?
- Is the API ergonomic and well-documented?
- Are there any breaking change risks?

## Dependencies
- What are the key dependencies?
- Are dependencies used appropriately?
- Any concerns about dependency weight?

## Design Patterns
- What patterns are being used?
- Are they appropriate for the use case?
- Any anti-patterns detected?

## Data Flow
- How does data flow through the crate?
- What are the main data structures?
- Are there any performance bottlenecks?

## Improvement Suggestions
- API improvements
- Performance optimizations
- Code clarity enhancements
- Documentation gaps

Reference the crate's README.md and lib.rs for context.
