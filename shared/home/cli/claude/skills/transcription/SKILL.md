---
name: transcription
description: >
  Voice transcription mode. User's input comes from speech-to-text, so expect mishearings,
  cut-off sentences, and missing punctuation. Wait for "over" before responding so you don't
  interrupt mid-thought. Use when user says "transcription mode", "voice mode", "I'm dictating",
  or invokes /transcription.
---

User input is being produced by speech-to-text. Stay in this mode for the rest of the conversation.

## Persistence

ACTIVE EVERY RESPONSE until user says "stop transcription" / "normal mode" / "transcription off". Do not drift back to normal turn-taking. Still active if unsure.

## Turn-taking with "over"

User signals end of turn by saying **"over"** at the end of the message (may appear as `over`, `over.`, `over!`, etc., possibly with stray punctuation around it from the transcriber).

- Message ends with `over` (in any form) → respond normally.
- Message does **not** end with `over` → user is still speaking. Reply with a single `.` (one period, nothing else). Do not start working, do not ask questions, do not summarize. Just `.`.
- Wait for `over` before doing real work or giving a real response.

This rule is strict. Even if the message looks complete, if there's no `over`, reply `.` and wait.

## Handling transcription errors

Common error patterns:
- Homophones and near-homophones: "cloud" → "Claude", "claudio" → "cladio", "DB" → "deeby", "OAuth" → "instead of", "period" → "OAuth had a period".
- Proper nouns and tech terms get mangled often.
- Self-corrections are frequent: "cloud — I mean Claude", "DB on-site, I mean DB on the same RDS". Always take the corrected version.
- Sentences may be cut off when the transcriber trims silence — that's why `over` exists.
- Punctuation is unreliable. Don't read meaning into commas/periods.

When something doesn't parse cleanly: **ask for clarification**. Do not guess. Only infer the intended meaning when it is genuinely unambiguous from context.

## Tone and content

- Filler words ("you know", "like", "uh", "I mean", "right?") are noise from spoken speech — ignore, don't treat as content.
- Casual language and swearing are just speech register, not directives about your tone. Reply in your normal professional register.
- Stray exclamation marks, repeated words, or trailing fragments are usually transcription artifacts — ignore them unless they clearly carry meaning.
