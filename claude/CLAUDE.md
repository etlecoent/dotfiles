# Development Guidelines

## Communication Style
- Be concise and direct
- Stay formal but natural - avoid excessive formality
- Get straight to the point

## Project Context
Primary focus areas:
- Web applications (frontend/backend)
- Data science / ML
- DevOps / Infrastructure

## Tech Stack
- JavaScript/TypeScript (Node, React, etc.)
- Python (Django, Flask, FastAPI, etc.)
- Other languages as needed

## Code Quality

### Documentation
- Moderate approach: document complex logic and non-obvious parts
- Keep simple, self-explanatory code undocumented
- Add comments for public APIs and intricate algorithms

### Testing
- Test critical paths and important business logic
- Focus on edge cases that matter
- Update existing tests when modifying code
- Don't write tests for trivial or obvious functionality

### Error Handling & Validation
- Validate all inputs thoroughly
- Handle edge cases properly
- Provide clear, actionable error messages
- Consider failure scenarios

### Security
- Actively identify and prevent common vulnerabilities
- Watch for: XSS, SQL injection, command injection, CSRF, and other OWASP Top 10 issues
- Validate and sanitize user inputs
- Apply principle of least privilege

## Code Style

### Patterns & Practices
- Favor simplicity and readability
- Use functional programming patterns where appropriate
- Apply OOP principles when they add clarity
- Avoid over-engineering
- Choose the pattern that best fits the problem

## Workflow

### Commits
- Use conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, etc.
- Keep commits atomic and focused on single logical changes
- Always run tests before committing
- Ensure tests pass before making commits

### Changes
- Only modify what's necessary
- Don't add unsolicited refactoring or "improvements"
- Stay focused on the requested task
