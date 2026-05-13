# Contributing to devcontainer-base

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful, inclusive, and constructive in all interactions.

## How to Contribute

### Reporting Bugs
1. Check if the bug has already been reported
2. Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md)
3. Include:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details
   - Relevant logs/screenshots

### Suggesting Features
1. Check if the feature has been suggested
2. Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md)
3. Explain the use case and benefit

### Submitting Changes

1. **Fork the repository**
```bash
git clone https://github.com/Your-Username/devcontainer-base.git
cd devcontainer-base
```

2. **Create a feature branch**
```bash
git checkout -b feature/your-feature-name
```

3. **Make your changes**
   - Update Dockerfile, devcontainer.json, or other files
   - Follow the existing code style
   - Test your changes locally

4. **Test your changes**
```bash
# Build the Docker image
docker build -t devcontainer-base:test -f .devcontainer/Dockerfile .

# Test basic functionality
docker run --rm devcontainer-base:test node --version
docker run --rm devcontainer-base:test python3 --version
```

5. **Run validation**
```bash
# Validate JSON files
python3 -m json.tool .devcontainer/devcontainer.json

# Check shell scripts
shellcheck .devcontainer/post-create.sh
```

6. **Commit your changes**
```bash
git add .
git commit -m "feat: description of your changes"
```

Use conventional commits (recommended):
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation
- `refactor:` for code refactoring
- `ci:` for CI/CD changes
- `build:` for build-related changes

Commit message format:
```text
type(scope): short description
```

Examples:
```text
feat(devcontainer): add podman support
fix(ci): correct docker build cache key
docs(readme): clarify quick-start steps
```

Notes:
- Keep the subject line under 100 characters.
- Do not end the subject with a period.
- Use lowercase commit types.

7. **Push to your fork**
```bash
git push origin feature/your-feature-name
```

8. **Create a Pull Request**
   - Use the [PR template](.github/pull_request_template.md)
   - Link related issues
   - Describe what you've changed and why

## Modifying the Dockerfile

When updating the Dockerfile:

1. **Version Pinning**: Use specific versions for tools and packages when possible
```dockerfile
RUN npm install -g package@2.0.0
```

2. **Layer Cleanup**: Combine RUN commands to reduce layers
```dockerfile
RUN apt-get update && \
    apt-get install -y package1 package2 && \
    apt-get clean
```

3. **Testing**: Build and verify all tools work:
```bash
docker build -t test -f .devcontainer/Dockerfile .
docker run --rm test node --version
docker run --rm test python3 --version
```

## Updating Configuration Files

### devcontainer.json
- Keep extensions relevant to development
- Test extensions work in VS Code
- Document port usage

### docker-compose.yml
- Ensure services align with Dockerfile
- Keep environment variables consistent
- Document volume mounts

### post-create.sh
- Make script idempotent (safe to run multiple times)
- Add error handling
- Provide helpful messages

## Documentation

When contributing:
- Update README.md if you add features
- Update DEVCONTAINER.md for container changes
- Update CI-CD.md for workflow changes
- Keep documentation in English

## Pull Request Process

1. Update documentation as needed
2. Ensure all tests pass (check Actions tab)
3. Wait for review approval
4. Maintainer will merge when ready

## Versioning and Changelog

This repository follows Semantic Versioning (SemVer):
- MAJOR: incompatible changes
- MINOR: backward-compatible features
- PATCH: backward-compatible fixes

`CHANGELOG.md` is maintained automatically from Conventional Commits using Release Please.

Automation involved:
- On merges to `main`, `release-please.yml` opens/updates a release PR.
- The release PR updates `CHANGELOG.md`, bumps version metadata, and creates a tag when merged.

Because release automation depends on commit messages, conventional commits are strongly recommended to keep changelog/version generation clean.

## Development Workflow

### Local Setup
```bash
git clone https://github.com/jasonouellet/devcontainer-base.git
cd devcontainer-base
git checkout -b feature/your-feature
```

### Development
```bash
# Build local image
docker build -t devcontainer-base:dev -f .devcontainer/Dockerfile .

# Test changes
docker run -it -v "$(pwd):/workspace" devcontainer-base:dev bash
```

### Before Submitting
```bash
# Verify Dockerfile builds
docker build -f .devcontainer/Dockerfile .

# Check JSON validity
python3 -m json.tool .devcontainer/devcontainer.json

# Lint shell scripts
shellcheck .devcontainer/post-create.sh
```

## Questions?

- Create a GitHub Discussion
- Open an issue with the question tag
- Check existing documentation in CI-CD.md and DEVCONTAINER.md

## License

By contributing, you agree that your contributions will be licensed under the project license.

---

Thank you for contributing to devcontainer-base! 🎉
