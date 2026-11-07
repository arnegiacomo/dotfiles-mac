# Global agent instructions

These are defaults for every project. Project instructions (a repo's AGENTS.md or CLAUDE.md) override them, and what I say in the conversation overrides both.

## Writing style

- Use sentence case for headers, not title case
- Use spaced hyphens ` - ` (space, hyphen, space) where an em dash would go. Never use em dashes
- Don't make up or embellish content. Stick to what I've said - rephrasing is fine, inventing is not
- Default to English for code, comments, commit messages, and identifiers - even in Norwegian-context repos, unless the existing code is already Norwegian

## About me

Full-stack developer in fintech, plus personal/hobby projects outside it. Pitch explanations to my level:

- Assume fluency in modern Java (Quarkus, Maven / Gradle), vanilla JS / Vue, SQL, Docker and CI pipelines
- Familiar but not expert - explain more in TypeScript, Python, Rust, bash, Kubernetes, and hardware (Raspberry Pis, microcontrollers)
- I'm actively growing in TypeScript, architecture, infra and observability - explain the reasoning behind choices there

## Working style

- Ask when different readings of the task would lead to materially different or hard-to-reverse work; otherwise state the assumption and proceed
- Prefer less code over more - simplicity is a feature
- When reviewing, be strict and objective
- It's always valid to pause mid-task and question whether the current approach is right - surface doubts rather than push through them
- This is also a learning experience - don't assume expertise across all areas of the stack. When making non-obvious decisions, briefly explain the reasoning. Go deeper when asked
- If a different tool, library, or approach would fit better than what's already in use, briefly recommend it with the tradeoff. Don't silently substitute - I'll choose.

## Code style

Preferences, not hard rules - existing codebase conventions take precedence when they differ.

- Flat functions: early returns and guard clauses over nested branches
- Keep error checking simple and flat - no overly verbose defensive code
- Prefer immutable values and pure functions
- Prefer static over dynamic: explicit types, no runtime magic

## Documentation

- Document what's there, not the diff - explain how the code works now, never how it changed
- Comments are for non-trivial decisions, external references, or genuinely non-obvious logic; not for narrating what the code does
- When documentation is warranted, keep it close to the source - line comments and standard function docs (Javadoc, JSDoc) over top-level architecture essays
- Keep the language simple and direct - no fluff
- Preserve the structure and voice of user-authored prose. Make targeted edits rather than replacing it wholesale

## Response style

- End with the result or open questions; skip recaps of what changed - I can read the diff
- Answer the question that was asked, not adjacent ones

## Commits

- Never commit or push unless I explicitly ask
- Conventional commits format: `type: ref description` or `type(scope): ref description`
- Scope is optional - include it when it meaningfully narrows the change, omit otherwise
- Reference the issue/ticket: `feat: #123 add login flow` or `refactor(auth): #456 simplify token refresh`
- If no ticket is apparent from the branch name or recent commits, ask; omit the ref if there is none
- Keep commit messages to a subject line unless I ask for a body
