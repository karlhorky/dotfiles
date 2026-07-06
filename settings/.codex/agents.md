# GitHub

- use `gh` CLI for GitHub interactions, always elevated
- strongly prefer editing PR descriptions from the current GitHub body, to avoid overwriting manual edits:

  ```bash
  gh pr view "$PR_NUMBER" --json body --jq '.body' |
    sed 's/<exact old text>/<exact new text>/' |
    gh pr edit "$PR_NUMBER" --body-file -
  ```

  - replace exact, unique text only

- PR descriptions
  - start with problem, then solution
  - do not use `## Summary`
  - do not add empty or near-empty `## Testing` sections
  - after the prose, add checked checkboxes for completed changes
  - checkbox items must describe positive completed changes only
  - keep checkbox items sentence-cased with uppercase starting letters (`- [x] Add ...`, not `- [x] add ...`)
  - checkbox items must be actionable: decide the action now instead of writing placeholders like `Consider ...`
  - do not add checkbox items for things kept unchanged or not done
  - place screenshots, videos, and other media in the next paragraph after the prose they support, usually after a colon
    - do not collect media in a separate screenshots section
    - do not name screenshot files in prose when the media itself should appear there

# Terminal

- security: prefer short singular shell commands, so users can allowlist narrow command prefixes in settings
  - eg. prefer running `pwd` with a `workdir` over `cd <dir> && <very long command>`
  - this helps users keep approval prompts enabled instead of relying on broad bypass modes like `--dangerously-skip-permissions` or `--yolo`

# Writing Prose

- keep writing terse
- do not bury the lede: lead with the main point, problem, decision, or user-visible outcome before setup or history
- avoid fluff or filler words that add no value
- prefer simple English when possible
- write like a spec document or documentation
  - include technical nouns, verbs, names (eg. symbol names)
  - aim for correctness and precision
  - but DO NOT make it long or include a lot of jargon
- avoid vague AI slop pseudo-technical jargon or colloquialisms like:
  - `data`
  - `wire up`
  - `wiring`
  - `make it click`
  - `fan out`
  - `gives` instead of technical language like `returns`, `queries`, `computes`, `renders`, etc
  - `carries` instead of technical language like `contains`, `includes`, `stores`, `references`
- substitutions
  - database: `rows` -> `records`
  - semicolons -> hyphens, parentheses, commas, or periods
  - em dashes -> hyphens, parentheses, commas, or periods
- keep high information density by packing context into concise nouns and qualifiers
  - eg. `Switch Replit to Deno Deploy in rest-apis deck, clarify`
- use canonical filenames verbatim when common
  - eg. `agents.md`, `package.json`, `pnpm-workspace.yaml`
- use canonical entity names verbatim, prefer slug form when that is the common name
  - eg. `rest-apis`, `react-forms-and-useeffect`
- avoid alternate labels when a canonical name already exists
- commit messages, PR titles, PR descriptions
  - before you start writing a commit message, PR title, or PR description, take your time to collect the background information you need (place special emphasis on the "why" and the history)
  - commit title format
    - single main change: `<primary change>`
      - eg. `Switch GraphQL Explorer to GraphQL.org SWAPI playground`
    - if multiple main changes are needed: `<primary change>, <important side effect>, ...`
      - eg. `Move TS exercises to slideDecks, add lint/TS excludes, update CI path`
  - include what changed + how it changed + why (the why is something you often forget, remember that it is about the original motivation, background and human aspect)
    - example 1
      - bad: `Restore Fall cohort fixtures in Fusion byline assertions` (only what + where)
      - good: `Restore Fall cohort fixtures for consistency and smaller Fusion test diff` (what + where + why)
    - example 2
      - bad: `Expand Fusion additional-candidate predicate for null assessments` (names a side effect, not the human why)
      - good: `Invert Fusion additional-candidate predicate for readability` (what + how + human why)
    - example 3
      - bad: `Make Flex cohort appointments content-only and dateless` (misses campus + why)
      - good: `Prep Flex cohort creation by dropping sync-format appts, dates, campus` (what + how + why)
  - use imperative wording (`Add`, `Link`), avoid present-tense (`Adds`, `Links`)
  - avoid vague subjects like `Refine`, `Update file`, `Misc fixes`
    - subjects must name the concrete changed object and action
    - eg. `Clarify commit subject rule, mention dist only for dist-only commits`
    - derive object nouns from changed paths, added code, edited headings/section labels
      - eg. `app.config.ts`, `nodeLinker: hoisted`, `--single-quote`
      - eg. to refer to sections of a document
        - `<section> section of <lecture slug> lecture notes`
    - use explicit qualifiers, avoid vague qualifier placement
      - example 1
        - bad: `Clarify graphql lecture notes and GitHub profile code examples`
        - good: `Clarify GitHub profile section of graphql lecture notes`
  - describe all completed changes exhaustively
  - avoid mentioning logical "housekeeping" or "cleanup" or "build" extension activities (eg. generating `dist` files, bumping all sibling ids) in commit subjects
  - prefer the shortest concrete object-action subject first
  - use only the commit subject in 99% of cases, avoid using commit message body
    - the 1% case is when we should link to other things or explain a complicated error case deeply
  - keep commit message subject lines to max 72 characters
  - if a clear exhaustive subject exceeds 72 chars, split the work into multiple commits
  - exception to canonical filename/entity-name rules above
    - if the subject would exceed 72 chars, fall back to abbreviated, short names
      - eg. `TS exercise` instead of `typescript-fundamentals-exercises`
- issue descriptions, issue comments, PR descriptions, PR comments
  - include concise background and history when documenting follow-up work
    - order context by the most relevant recent outcome or cause first, then older background, then solution
      1. current problem / regression / decision
      2. internal repo history / external motivation
         - eg. upstream ecosystem/tooling behavior change
      3. solution
    - include concrete references (commit / PR / issue permalinks) for provenance
    - for upstream docs/source claims, use commit-pinned GitHub permalinks with line anchors
      - prefer `?plain=1#Lx` or `?plain=1#Lx-Ly` for Markdown or MDX

# Code style

- preserve existing code comments unless they are wrong or the user asks to change them
- keep diffs minimal and preserve existing naming and formatting unless the change requires otherwise
- prefer the Principle of Least Surprise over cleverness when choosing value shapes, ids, naming, and control flow
- prefer simplicity and transparent program flow over abstraction and indirection
- prefer inline values over single-use variables unless a local is needed for narrowing or clarity
- avoid speculative fallbacks, defensive guards, and dead code paths for cases not present in the current data

# Interacting with user

- prefer simple textual representations, do not use ASCII art to draw tables and similar unless requested
- if asking the user to choose, present the options as a numbered or lettered list so each can be referenced uniquely
