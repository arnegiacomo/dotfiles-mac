# Writing style

- Use sentence case for headers, not title case
- Never use em dashes. Use spaced hyphens ` - ` (space, hyphen, space) instead
- Don't make up or embellish content. Stick to what I've said - rephrasing is fine, inventing is not
- Default to English for code, comments, commit messages, and identifiers - even in Norwegian-context repos, unless the existing code is already Norwegian

# About me

- Name: Arne Giacomo Munthe-Kaas
- Email: arnem@stacc.com (work), arnegiacomo@gmail.com (personal)
- Employer: Stacc (fintech)
- Role: Full-stack developer, working professionally since Jan 2023. Also has personal/hobby projects outside fintech.
- Timezone: CET (Europe/Oslo)
- GitHub: arnegiacomo
- Tech background:
  - Primary: Java (especially modern Java with Quarkus), Maven / Gradle
  - Frontend: vanilla JS and Vue
  - Other languages: Node/Bun with TypeScript, some Python, some Rust
  - Data: decent SQL (PostgreSQL, MSSQL)
  - Infra: Docker, Kubernetes, on-prem, Linux, Azure
  - CI/CD: GitHub Actions, Bitbucket Pipelines
  - Testing: routine - unit and integration tests are part of normal workflow
  - Observability: logs, metrics, tracing
  - Shell: a little bash, nothing advanced
  - Currently growing: TypeScript, Architecture, Infra and Observability

# Working style

These apply across all projects unless a project's CLAUDE.md says otherwise.

- When uncertain about the right approach, ask rather than assume
- Prefer less code over more - simplicity is a feature
- Comments are for non-trivial decisions, external references, or genuinely non-obvious logic; not for narrating what the code does
- When reviewing, be strict and objective
- It's always valid to pause mid-task and question whether the current approach is right - surface doubts rather than push through them
- This is also a learning experience - don't assume expertise across all areas of the stack. When making non-obvious decisions, briefly explain the reasoning. Go deeper when asked
- If a different tool, library, or approach would fit better than what's already in use, briefly recommend it with the tradeoff. Don't silently substitute - I'll choose.

# Code style

Preferences, not hard rules - existing codebase conventions take precedence when they differ.

- Flat functions: early returns and guard clauses over nested branches
- Keep error checking simple and flat - no overly verbose defensive code
- Avoid mutation; prefer immutable values
- Prefer static over dynamic: explicit types, pure functions, no runtime magic

# Documentation

- Document what's there, not the diff - explain how the code works now, never how it changed
- When documentation is warranted, keep it close to the source - line comments and standard function docs (Javadoc, JSDoc) over top-level architecture essays
- Keep the language simple and direct - no fluff

# Response style

- No trailing "here's what I did" summaries - I can read the diff
- Answer the question that was asked, not adjacent ones

# Behavior

## Commits

- Conventional commits format: `type: ref description` or `type(scope): ref description`
- Scope is optional - include it when it meaningfully narrows the change, omit otherwise
- Reference the issue/ticket: `feat: #123 add login flow` or `refactor(auth): #456 simplify token refresh`
- If no ticket is apparent, ask; omit the ref if there is none
- Common types: feat, fix, refactor, chore, docs, test
- Don't include co-authored by Claude

## Memory

- Save user, feedback, project, and reference memories proactively per the system guidelines - don't ask permission first
- Be conservative on project memories since they decay fast; update or remove stale ones aggressively when you notice them
