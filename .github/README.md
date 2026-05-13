# GitHub Configuration

This directory contains GitHub-specific configuration files for the devcontainer-base repository.

## Directory Structure

```
.github/
├── workflows/              # GitHub Actions workflows
│   ├── ci.yml             # CI: lint, validate, test, candidate publish
│   ├── cd.yml             # CD: candidate promotion and final publish
│   └── release-please.yml # SemVer release PR and changelog automation
├── ISSUE_TEMPLATE/        # Issue templates
│   ├── bug_report.md      # Bug report template
│   └── feature_request.md # Feature request template
├── pull_request_template.md
├── CODEOWNERS
└── dependabot.yml
```

## Workflows

### CI (`workflows/ci.yml`)
- Lint/validation/security checks
- Build and runtime tests
- Publish candidate image to GHCR as `ci-<sha>`
- Upload candidate metadata artifact

**Triggers:**
- Pushes to main or feature/first-version branches
- Pull requests to main
- Weekly schedule (security)
- Manual workflow dispatch

### CD (`workflows/cd.yml`)
- Promotes validated candidate image to final tags
- Creates GitHub release

**Triggers:**
- Tag push `v*`
- Manual workflow dispatch

**Guardrails:**
- Requires `release_tag` before final publish
- Blocks `latest` promotion when no `release_tag`

### Release Please (`workflows/release-please.yml`)
- Maintains `CHANGELOG.md` from Conventional Commits.
- Opens release PRs following SemVer.

## Configuration Files

### CODEOWNERS
Defines code ownership for automatic reviewer assignment on PRs.

### dependabot.yml
Automatically creates PRs for:
- GitHub Actions updates (weekly)
- Docker base image updates (monthly)

### Issue Templates
- **bug_report.md**: For reporting issues
- **feature_request.md**: For suggesting enhancements

### Pull Request Template
Guides contributors to provide necessary information in PRs.

## Using GitHub Actions

### View Workflows
Go to **Actions** tab to see:
- Workflow history
- Individual run details
- Logs and outputs
- Artifacts

### Manual Trigger
Workflows support manual dispatch:
1. Go to **Actions** tab
2. Select **CI**, **CD**, or **Release Please**
3. Click **Run workflow**
4. Choose branch and parameters
5. Click **Run workflow**

### Workflow Status Badge
Add to README:
```markdown
[![CI](https://github.com/jasonouellet/devcontainer-base/actions/workflows/ci.yml/badge.svg)](https://github.com/jasonouellet/devcontainer-base/actions/workflows/ci.yml)
[![CD](https://github.com/jasonouellet/devcontainer-base/actions/workflows/cd.yml/badge.svg)](https://github.com/jasonouellet/devcontainer-base/actions/workflows/cd.yml)
```

## GitHub Container Registry (GHCR)

### Publish flow
- CI publishes candidate image: `ghcr.io/jasonouellet/devcontainer-base:ci-<sha>`
- CD promotes candidate to final tags: `vX.Y.Z` and `latest`

### Pull images
```bash
docker pull ghcr.io/jasonouellet/devcontainer-base:latest
```

## Security

### GitHub Actions Permissions
The workflows declare minimal required permissions:
- `contents: read` - Read repository contents
- `packages: write` - Push to GHCR
- `security-events: write` - Upload security results

### Secrets
Uses `GITHUB_TOKEN` (automatically provided) for:
- Logging into GHCR
- Creating releases
- Uploading test results

## Monitoring

### Check Workflow Status
- **Actions** tab shows CI and CD workflow runs
- **Security** tab shows vulnerability alerts
- **Packages** tab shows published images

### Debugging Workflows
1. Go to **Actions** tab
2. Click the failed CI or CD run
3. Click the failed job
4. Review logs for errors

### View Published Images
1. Go to **Packages** tab
2. Click `devcontainer-base` package
3. View tags, versions, and pull commands

## Contributing

When contributing, ensure:
- [ ] Workflows pass (check Actions)
- [ ] Code follows existing style
- [ ] Documentation is updated
- [ ] Configuration files are valid

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.

## Further Reading

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
- [Dependabot](https://docs.github.com/en/code-security/dependabot)
