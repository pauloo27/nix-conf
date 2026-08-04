---
name: brief
description: Generates a brief.md to pass context or task instructions from this conversation to a different AI agent working on separate (but related) work.
---

# Brief Generation Prompt

You are generating a `brief.md` to **pass context to another AI agent** that will do its own work — not continue yours.

This is NOT a continuation handover. The receiving agent has a different task, possibly in a different repo or app. It just needs to understand something from this conversation to do its job well.

## Examples of when this is used

- You changed how deployments work in an ArgoCD config repo → other agents managing individual apps need to know the new pattern
- You discussed an architectural decision → another agent working on a different part of the system needs that context
- You built something → another agent needs to integrate with it or use it

## Goal

Create a focused brief containing **only what the receiving agent needs**. Ask the user (or infer) what the brief is for and who it's aimed at.

Do:
- Focus on what's relevant to the receiving agent's work, not everything that happened here.
- Include usage patterns, interfaces, or conventions if that's what they need.
- Be specific and actionable — the receiving agent should know what to do with this info.
- Keep it as short as possible.

Do NOT:
- Dump everything from the conversation.
- Include your own work history or status (that's what `/handover` is for).
- Invent context the receiving agent might need — stick to what was actually discussed.
- Over-structure it. Match the complexity to the content.

---

## Structure

Keep it simple. A brief can be as short as a few lines.

```
# Brief

## What you need to know
<the key context, decision, change, or pattern the receiving agent needs>

## What this means for your work
<how this affects what the receiving agent is doing — be specific>

## Details
<any specifics: new conventions, interfaces, config changes, usage examples>
```

Only add sections if they're needed. If the whole brief fits in 5 lines, that's fine.

## Output

Write clean Markdown to `./brief.md` in the current working directory. If that file
already exists, show the user its first lines and ask before overwriting.
