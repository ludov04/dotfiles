# Senior Engineer Code Review

Review the current changes as a senior engineer, focusing on correctness, consistency, and opportunities for simplification and refactoring.

## Step 1: Gather Changes

First, understand what has changed:

1. Run `git diff --name-only` to get the list of changed files
2. Run `git diff` to see the actual changes
3. If there are staged changes, also run `git diff --cached`

## Step 2: Understand the Context

For each changed file:

1. Read the **full file** (not just the diff) to understand the broader context
2. Identify the **adjacent code** - functions, types, and modules that interact with the changes
3. Look for **similar patterns** in the codebase using Grep/Glob to find related implementations

## Step 3: Review for Correctness & Consistency

Analyze the changes with these questions:

### Logic Correctness
- Are there any logical errors or edge cases not handled?
- Are null/undefined checks present where needed?
- Are error cases handled appropriately?
- Do the changes match the apparent intent?

### Consistency
- Do the changes follow existing patterns in the codebase?
- Are naming conventions consistent with surrounding code?
- Is the style consistent (early returns, functional patterns, etc.)?
- Are similar operations handled in similar ways?

## Step 4: Identify Repetition & Refactoring Opportunities

This is the **most important step**. Look beyond the immediate changes:

### Within the Changes
- Is there repeated logic that could be extracted into a helper function?
- Are there multiple similar conditionals that could be unified?
- Could switch statements replace chains of if/else?

### In Adjacent Code
- Do the changes duplicate logic that already exists elsewhere?
- Could existing utilities be used instead of new code?
- Are there now multiple places doing the same thing that should be consolidated?

### Abstraction Opportunities
Look for chances to create better abstractions:

1. **Composable functions** - Can we extract small, pure functions that compose well?
2. **Reusable hooks** - For React code, can repeated stateful logic become a custom hook?
3. **Shared types** - Are there inline types that should be extracted and shared?
4. **Configuration over code** - Can hardcoded values become configurable?
5. **Higher-order patterns** - Can we create a function that generates similar functions?

### Simplification
- Can complex logic be broken into smaller, named steps?
- Are there nested conditions that could be flattened?
- Can imperative loops become declarative array operations?
- Are there abstractions that are over-engineered for their use case?

## Step 5: Generate Review Report

Present findings in this format:

```markdown
## Code Review Summary

### Overview
Brief summary of what the changes accomplish.

### ✅ What Looks Good
- Point out things done well
- Acknowledge good patterns followed

### ⚠️ Potential Issues
For each issue:
- **Location**: `file:line`
- **Issue**: Description of the problem
- **Suggestion**: How to fix it
- **Code**: Show the suggested change if applicable

### 🔄 Refactoring Opportunities
For each opportunity:
- **Pattern Found**: Describe the repetition or complexity
- **Files Affected**: List relevant files
- **Proposed Abstraction**: Describe the cleaner approach
- **Benefits**: Why this would be better (reduced duplication, clearer intent, better testability)
- **Example**: Show before/after code

### 💡 Simplification Suggestions
- Specific ways to reduce complexity
- Opportunities to use existing utilities
- Ways to improve readability

### 📋 Action Items
Prioritized list of suggested changes:
1. [ ] Critical: Must fix before merging
2. [ ] Important: Should address
3. [ ] Nice to have: Consider for follow-up
```

## Review Principles

When reviewing, embody these senior engineer qualities:

1. **Be constructive** - Every criticism should come with a suggestion
2. **Consider the bigger picture** - Think about maintainability and future changes
3. **Respect existing patterns** - Unless there's a good reason to change them
4. **Avoid bike-shedding** - Focus on meaningful improvements
5. **Think about the team** - Will others understand this code?
6. **Balance pragmatism** - Not every refactor is worth the churn

## Example Refactoring Patterns to Look For

### Pattern: Repeated null checks
```typescript
// Before
if (user != null && user.profile != null && user.profile.settings != null) {
  return user.profile.settings.theme
}

// After - use optional chaining
return user?.profile?.settings?.theme
```

### Pattern: Similar functions with slight variations
```typescript
// Before
function getUserName(user: User) { return user.name }
function getTeamName(team: Team) { return team.name }

// After - generic helper
const getName = <T extends { name: string }>(entity: T) => entity.name
```

### Pattern: Repeated async patterns
```typescript
// Before - repeated in many places
try {
  setLoading(true)
  const result = await fetchData()
  setData(result)
} catch (e) {
  setError(e)
} finally {
  setLoading(false)
}

// After - custom hook
const { data, error, loading } = useAsync(() => fetchData())
```

### Pattern: Configuration objects instead of many parameters
```typescript
// Before
function createUser(name: string, email: string, role: string, active: boolean, verified: boolean)

// After
function createUser(config: CreateUserConfig)
```
