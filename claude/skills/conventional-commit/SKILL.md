---
name: conventional-commit
description: Create commits following conventional commit format with automated quality checks. Use when the user asks to commit changes, create commits, or save their work. The skill handles staging files by work items, running linting/formatting/tests, and generating commit messages based on actual changes.
---

# Conventional Commit Skill

Create well-structured commits following conventional commit format with automated quality checks.

## Workflow

### 

### 1. Analyze Changes and Group by Work Items

Run git status and git diff to understand all changes:

```bash
git status
git diff
git diff --staged
```

Group related changes into logical work items. A work item is a cohesive set of changes that accomplish a single purpose:

- **Feature work item**: New functionality (may span multiple files)
- **Fix work item**: Bug fixes
- **Refactor work item**: Code restructuring without behavior changes
- **Docs work item**: Documentation updates
- **Test work item**: Test additions or updates
- **Chore work item**: Maintenance tasks (deps, config, etc.)

Each work item becomes one commit. Group by files if necessary. 

### 2. User validation

Before going to the next step. Present the user with a summary of the planned commits based on the work items identified. For each work item, show:
- The type of change (feature, fix, refactor, etc.)
- The files involved
- A brief description of the change (based on the diff)
With AskUSerQuestionTool, prompt the user to review the planned commit list and make adjustments based on the user's feedback.

### 3. For Each Work Item

#### 3a. Stage Files

Stage only the files belonging to the current work item:

```bash
git add <file1> <file2> <file3>
```

Never use `git add .` or `git add -A` - always stage specific files to avoid including unintended changes.


#### 3b. Generate Commit Message

Analyze the staged changes to generate a conventional commit message:

**Format**:
```
<type>: <description>

[optional body]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Type selection** (based on staged changes):
- `feat`: New feature or functionality
- `fix`: Bug fix
- `refactor`: Code restructuring without behavior change
- `docs`: Documentation changes only
- `test`: Test additions or updates
- `chore`: Maintenance (deps, config, build tools)
- `style`: Code style/formatting (whitespace, semicolons)
- `perf`: Performance improvements
- `ci`: CI/CD changes

**Description**:
- Lowercase, imperative mood ("add feature" not "added feature")
- No period at the end
- Max 72 characters
- Focus on *what* and *why*, not *how*

**Body** (optional):
- Add if the change needs explanation beyond the description
- Explain motivation, context, breaking changes
- Keep lines under 72 characters

**Examples**:
```
feat: add user authentication with JWT

Implement JWT-based authentication system with refresh tokens.
Includes login, logout, and token validation middleware.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

```
fix: resolve memory leak in event listeners

Event listeners were not properly cleaned up on component unmount,
causing memory accumulation. Added cleanup in useEffect.

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

```
refactor: extract validation logic to separate module

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

#### 3c. Create Commit

Use heredoc format for proper multi-line message handling:

```bash
git commit -m "$(cat <<'EOF'
<type>: <description>

[optional body]

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

Verify success with `git status` or `git log -1`.

### 4. Repeat for Remaining Work Items

Continue with the next work item until all changes are committed.

## Important Notes

- **Stage specific files** - never use `git add .` or `git add -A`
- **One work item = one commit** - don't mix unrelated changes
- **Generate messages from actual changes** - read the diff to understand what changed
- **Always include co-author tag** for transparency
- **Use heredoc** for commit messages to handle multi-line formatting correctly
- **Don't push** unless explicitly requested by the user
