---
name: handover
description: Generates a handover.md so another AI agent can resume this work in a fresh context. Use this when the next agent should pick up where you left off.
---

# Handover Generation Prompt

You are generating a `handover.md` so another AI agent can **pick up where this session left off**.

## Goal

Create a concise summary of what was done, what's left, and what the next agent needs to continue.

Do:
- Summarize what was worked on, decisions made, current status, and what's next.
- Stay conceptual and structured.
- Assume the next agent can ask the user clarifying questions.
- **Scale to the session's complexity.** A short chat gets a short handover.

Do NOT:
- Include code, diffs, or implementation details.
- Write deep technical breakdowns.
- Invent missing context.
- Restate the entire conversation.
- Force sections that don't apply — omit them.

---

## Structure

Use only the sections that apply.

For **simple sessions** (quick fix, small change):

```
# Handover

## What happened
<1-3 sentences: what was discussed/done>

## Status
<what's done, what's not>

## Next steps
<what to pick up>
```

For **complex sessions**, expand with any of these as needed:

- **Project Context** — what the project is, why this work was initiated
- **Problems Addressed** — key challenges, what triggered them, constraints
- **Solutions & Decisions** — approaches chosen, rationale, alternatives considered
- **Current Status** — completed / partially done / deferred
- **Open Questions** — missing info, pending decisions, things needing clarification
- **Assumptions Made** — temporary assumptions that may need validation
- **Suggested Next Directions** — focus areas, what to clarify first

Keep it concise, structured, and scannable.

## Output

Write clean Markdown to `./handover.md` in the current working directory. If that file
already exists, show the user its first lines and ask before overwriting.
