---
name: classify-spec
description: Read a spec file and classify it for the correct agent
---

Read the spec and classify it as one of the following agents:

- @dev-agent — spec mentions: development, implementation, functionality, API, data, logic
- @designer-agent — spec mentions: design, colors, color palette, aesthetic, look and feel, layout, typography

**If both signals are present:** classify as @dev-agent.
**If uncertain:** classify as @dev-agent.

Output exactly one line:
`CLASSIFY: @dev-agent` or `CLASSIFY: @designer-agent`
