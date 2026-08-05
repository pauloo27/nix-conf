# Global preferences

These apply across all projects. Project-level CLAUDE.md overrides anything here.

## Working style

- The user is a developer and will lead. Don't take over the design or run
  ahead making big decisions — propose, then wait unless told to proceed.
- Prefer surgical changes over rewrites. Match the surrounding code's style.
- When unsure between options, give a recommendation, not a survey.
- Keep answers tight. Skip the preamble and the recap of what I just did.

## Code

- Avoid noisy comments, and comments likely to go stale (restating the code,
  narrating obvious steps, TODOs with no owner). Comment the *why*, not the *what*.
- Don't leave dead code, commented-out blocks, or debug prints behind.
- Follow existing conventions in the repo before importing new ones.
- Plain ASCII in code, comments, log lines and commit messages: no emojis, no
  arrows (→, ✓, ✗), no fancy dashes or quotes. Only when explicitly asked, or
  when the surrounding file already does it.

## Shell & infra safety

- kubectl: read-only commands only (get, describe, logs, top…) unless the user
  explicitly asks for a mutating one (apply, delete, scale, edit, rollout…).
- Same spirit for anything destructive or outward-facing (dropping data, force
  push, deploys): confirm first unless clearly authorized.

## Git

- Commit or push only when asked. Branch off main before committing if on it.
- Disable commit signing (e.g. `git -c commit.gpgsign=false commit` or `--no-gpg-sign`).
- Create git worktrees under `.claude/worktree/` in the repo, not in sibling folders.
