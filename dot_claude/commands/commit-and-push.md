---
description: Analyze staged changes, create a commit message, commit, and push to remote
---

Please analyze the staged changes in git and create an appropriate commit message following these guidelines:

1. Check the current branch
   1. If we are on main, create a branch with a descriptive name (using the diff) starting with `ludo/`
2. Run `git diff --staged` to see what changes are staged
   1. If some changes are staged, only analyse and commit those changes
   2. If no changes were staged, look at the diff between the current branch and main, if applicable (see best practices), do multiple commits
3. Create a commit message that:
   - Summarizes the changes clearly and concisely
   - Follows the existing commit style in this repository
4. Commit the changes using the generated message
5. Push the changes to the remote branch


## Best practices for commits

- Atomic commits: Each commit should contain related changes that serve a single purpose
- Split large changes: If changes touch multiple concerns, split them into separate commits (only if no changes were staged)
- Conventional commit format: Use the format <type>: <description> where type is one of:
  - feat: A new feature
  - fix: A bug fix
  - docs: Documentation changes
  - style: Code style changes (formatting, etc)
  - refactor: Code changes that neither fix bugs nor add features
  - perf: Performance improvements
  - test: Adding or fixing tests
  - chore: Changes to the build process, tools, etc.
- Present tense, imperative mood: Write commit messages as commands (e.g., "add feature" not "added feature")
- Concise first line: Keep the first line under 72 characters


## Guidelines for Splitting Commits
When analyzing the diff, consider splitting commits based on these criteria:

Different concerns: Changes to unrelated parts of the codebase
Different types of changes: Mixing features, fixes, refactoring, etc.
File patterns: Changes to different types of files (e.g., source code vs documentation)
Logical grouping: Changes that would be easier to understand or review separately
Size: Very large changes that would be clearer if broken down

## Important:
- After pushing, confirm the push was successful