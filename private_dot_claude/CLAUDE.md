# Personal Development Preferences

## Refactoring & Code Reuse

Before implementing new functionality, always:

1. **Search for existing patterns** - Look for functions, utilities, or components in the codebase that already do something similar. Use Grep/Glob to find related code before writing new code.

2. **Identify reuse opportunities** - When you find similar logic in multiple places, suggest extracting it into a shared function, hook, or utility.

3. **Prefer composition** - Break down solutions into small, composable pieces. Favor many small functions over few large ones.

4. **Flag duplication** - If you notice code that duplicates existing functionality, point it out and suggest consolidation, even if it's outside the immediate scope of the task.

5. **Check for existing utilities** - Before creating helpers for common operations (string manipulation, array transformations, date formatting, etc.), check if the codebase already has utilities for this or if a library the project uses provides it.

When suggesting refactors:
- Explain the benefit (reduced duplication, better testability, clearer intent)
- Show both the extraction and how call sites would change
- Consider if the refactor is worth the churn for the given context


## Functional Programming Style

Favor functional programming patterns:

1. **Use declarative array methods** - Prefer `map`, `filter`, `reduce`, `flatMap`, `find`, `some`, `every` over imperative loops (`for`, `while`, `forEach`).

2. **Compose functions** - Build complex operations by composing smaller pure functions. Use pipe/flow patterns when appropriate.

3. **Avoid mutation** - Return new objects/arrays instead of mutating existing ones. Use spread operators and immutable update patterns.

4. **Pure functions first** - Functions should be pure when possible (same input → same output, no side effects). Isolate side effects to the edges of the system.

5. **Favor expressions over statements** - Prefer ternaries and logical expressions over if/else when the result is a value. Use early returns to flatten logic.

6. **Leverage type inference** - Let TypeScript infer types from function composition rather than annotating everything explicitly.


## AWS CLI Profiles

This environment switches AWS profiles with shell helpers (native equivalents of oh-my-zsh's aws plugin):

- `asp <profile>` — set `AWS_PROFILE` for the current shell (tab-completes configured profiles; `asp` alone opens an fzf picker; `asp -u` clears it).
- `agp` — print the active profile.
- `aws-profiles` — list configured profiles (`aws configure list-profiles`).

Profiles use AWS SSO (`aws sso login`), not static keys. The active profile shows in the prompt via starship's `[aws]` module.

When running AWS CLI commands, select the right profile first with `asp <profile>` (or pass `--profile <profile>` / set `AWS_PROFILE=<profile>` inline) and confirm with `agp` — don't assume the default profile. If a call fails with an auth/expired-token error, run `aws sso login` (with the right profile active).