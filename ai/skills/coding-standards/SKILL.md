---
name: coding-standards
description: Apply when writing, reviewing, or refactoring any code.
---

# Coding Standards

## Principles
- SOLID and DRY, but don't be a zealot about it — pragmatism wins
- Readability over cleverness
- Fail loudly; never swallow errors silently

## File Structure
- Small, focused files over large, sprawling ones
- One responsibility per file — if you have to scroll, it's probably too big
- Prefer 50 ten-line files over 10 fifty-line files

## General
- Named constants over magic numbers
- Explicit over implicit
- If it's hard to test, it's probably badly structured
