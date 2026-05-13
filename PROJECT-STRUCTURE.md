# Project Structure

Complete overview of the devcontainer-base repository structure and its CI/CD pipeline.

## 📁 Repository Layout

```
devcontainer-base/
│
├── .devcontainer/                    # Development container configuration
│   ├── devcontainer.json            # VS Code Dev Containers config
│   ├── Dockerfile                   # Custom Docker image definition
│   ├── docker-compose.yml           # Docker Compose configuration
│   ├── post-create.sh               # Automated setup script
│   └── .devcontainerignore          # Files to exclude from container
│
├── .github/                          # GitHub-specific configuration
│   ├── workflows/                   # GitHub Actions workflows
│   │   ├── build-and-push.yml      # Build image + push to GHCR
│   │   ├── lint.yml                 # Linting & validation
│   │   └── security-scan.yml        # Security vulnerability scanning
│   ├── ISSUE_TEMPLATE/             # Issue templates
│   │   ├── bug_report.md           # Bug report template
│   │   └── feature_request.md      # Feature request template
│   ├── pull_request_template.md     # PR template for contributors
│   ├── CODEOWNERS                   # Code ownership rules
│   ├── dependabot.yml              # Automated dependency updates
│   └── README.md                    # GitHub directory documentation
│
├── examples/                         # Usage examples
│   └── README.md                    # Example configurations and workflows
│
├── README.md                         # Main project documentation
├── DEVCONTAINER.md                   # Detailed dev container guide
├── CI-CD.md                         # CI/CD pipeline documentation
├── CONTRIBUTING.md                   # Contribution guidelines
├── MAINTENANCE.md                    # Maintenance & operation manual
├── LICENSE                          # Project license
└── .gitignore                       # Git ignore rules
```

## 🔄 CI/CD Pipeline Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions Workflows                  │
└─────────────────────────────────────────────────────────────┘

                              │
                              ├─ Pushes to main/feature branches
                              ├─ Pull Requests to main
                              ├─ Version tags (v*.*.*)
                              └─ Manual workflow dispatch

                              ▼

        ┌────────────────────┬──────────────────┬──────────────┐
        │                    │                  │              │
        ▼                    ▼                  ▼              ▼
    ┌────────────┐    ┌─────────────┐   ┌──────────────┐  ┌─────────┐
    │   Build    │    │   Lint &    │   │  Security    │  │  Test   │
    │ & Push     │    │ Validate    │   │   Scan       │  │ (on PR) │
    │ (GHCR)     │    │             │   │              │  │         │
    └────────────┘    └─────────────┘   └──────────────┘  └─────────┘
    
    Docker Build    Hadolint          Trivy            Unit Tests
    Multi-platform  JSON validate     Dockerfile       Integration
    Platforms:      ShellCheck        security         Tests
    - amd64                           
    - arm64                           

        │                    │                  │              │
        └────────────────────┴──────────────────┴──────────────┘
                              │
                    ✅ if all checks pass
                              │
                              ▼
                    ┌──────────────────┐
                    │ Push to GHCR     │
                    │ if not PR        │
                    └──────────────────┘
                              │
                    ghcr.io/jasonouellet/
                    devcontainer-base:
                    - main
                    - feature/first-version
                    - v1.0.0
                    - sha-abc123...
                    - latest
```

## 📦 Workflows Explained

### Workflow 1: Build and Push

**File:** `.github/workflows/build-and-push.yml`

```
Input: Dockerfile + Build Args
  │
  ├─ Set up Docker Buildx (multi-platform)
  ├─ Log in to GitHub Container Registry
  ├─ Extract metadata (tags, labels)
  ├─ Build Docker image
  ├─ Run tests on PR
  └─ Push to GHCR (if not PR)

Output: Docker image in GHCR
```

**Triggers:**
- Pushes to main and feature/first-version
- Version tags (v1.0.0, etc.)
- Manual dispatch
- Pull requests (test only)

### Workflow 2: Lint and Validate

**File:** `.github/workflows/lint.yml`

```
Input: Repository files
  │
  ├─ Hadolint: Check Dockerfile
  ├─ JSON validation: devcontainer.json, docker-compose.yml
  └─ ShellCheck: Check shell scripts

Output: Lint results (pass/fail)
```

### Workflow 3: Security Scan

**File:** `.github/workflows/security-scan.yml`

```
Input: Source code + Dependencies
  │
  ├─ Trivy: Scan for vulnerabilities
  ├─ Dockerfile: Check for security issues
  └─ Upload results to GitHub Security tab

Output: Security report (SARIF format)
```

## 🔄 Automation Features

### Dependabot
- **GitHub Actions**: Weekly updates
- **Docker**: Monthly updates
- **Auto-merge**: Can be configured

### Branch Protection (Recommended)
```yaml
Require:
- ✅ status checks to pass before merging
- ✅ code reviews from CODEOWNERS
- ✅ dismissal of stale reviews
```

## 📊 Key Metrics

| Component | Technology | Status |
|-----------|-----------|--------|
| Base Image | AlmaLinux 9 | ✅ |
| Node.js | v20 LTS | ✅ |
| Python | v3.11 | ✅ |
| Docker | Latest stable | ✅ |
| GitHub CLI | Latest | ✅ |
| Git LFS | Latest | ✅ |
| Podman | Latest | ✅ |

## 🚀 Development Flow

### For Contributors

1. **Fork & Clone**
   ```bash
   git clone https://github.com/Your-Username/devcontainer-base.git
   ```

2. **Create Feature Branch**
   ```bash
   git checkout -b feature/my-feature
   ```

3. **Make Changes**
   - Modify Dockerfile, config files, or documentation
   - Test locally

4. **Commit & Push**
   ```bash
   git commit -m "feat: description"
   git push origin feature/my-feature
   ```

5. **Create Pull Request**
   - Use PR template
   - Describe changes
   - Link issues

6. **CI Runs Automatically**
   - ✅ Lint checks
   - ✅ Security scan
   - ✅ Build image
   - ✅ Run tests

7. **Review & Merge**
   - Wait for approvals
   - Maintainer merges

### For Maintainers

1. **Release Planning**
   - Review PRs
   - Ensure tests pass
   - Check security alerts

2. **Create Release**
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

3. **CI/CD Publishes**
   - Workflow builds image
   - Pushes to GHCR
   - Creates GitHub Release

4. **Monitor**
   - Check Actions tab
   - Review security alerts
   - Update documentation

## 📋 Files Created

### Configuration & Automation
- ✅ `.github/workflows/build-and-push.yml` - Build & publish pipeline
- ✅ `.github/workflows/lint.yml` - Code quality checks
- ✅ `.github/workflows/security-scan.yml` - Security scanning
- ✅ `.github/CODEOWNERS` - Code ownership
- ✅ `.github/dependabot.yml` - Dependency automation

### Templates
- ✅ `.github/ISSUE_TEMPLATE/bug_report.md` - Bug reports
- ✅ `.github/ISSUE_TEMPLATE/feature_request.md` - Feature requests
- ✅ `.github/pull_request_template.md` - Pull requests

### Documentation
- ✅ `CI-CD.md` - CI/CD pipeline guide
- ✅ `CONTRIBUTING.md` - Contribution guidelines
- ✅ `MAINTENANCE.md` - Maintenance & operations
- ✅ `.github/README.md` - GitHub config documentation
- ✅ `examples/README.md` - Usage examples

## 🔒 Security Best Practices Implemented

- ✅ **No Hardcoded Secrets**: Uses GITHUB_TOKEN only
- ✅ **Minimal Permissions**: Workflows declare required permissions only
- ✅ **Regular Scanning**: Trivy scans for vulnerabilities
- ✅ **Dockerfile Linting**: Hadolint checks best practices
- ✅ **Dependency Updates**: Dependabot keeps packages current
- ✅ **Code Review**: CODEOWNERS require approvals

## 📈 Scalability

This setup supports:
- ✅ Multiple platforms (amd64, arm64, more)
- ✅ Multiple branches
- ✅ Semantic versioning
- ✅ Automated releases
- ✅ Multiple images per tag
- ✅ External usage via GHCR

## 🎯 Next Steps

1. **Test Locally**
   ```bash
   docker build -t devcontainer-base:test -f .devcontainer/Dockerfile .
   ```

2. **Push Initial Changes**
   ```bash
   git add .
   git commit -m "ci: add ci/cd pipeline"
   git push origin feature/first-version
   ```

3. **Monitor Workflows**
   - Go to Actions tab
   - Check run details
   - Review logs if needed

4. **Create First Release**
   ```bash
   git tag -a v0.1.0 -m "Initial release"
   git push origin v0.1.0
   ```

5. **Enable Branch Protection** (Optional)
   - Go to Settings → Branches
   - Add protection rules
   - Require status checks and reviews

---

**For detailed information:**
- 📖 [CI-CD.md](CI-CD.md) - Pipeline details
- 🔧 [DEVCONTAINER.md](DEVCONTAINER.md) - Container setup
- 🤝 [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- 📋 [MAINTENANCE.md](MAINTENANCE.md) - Operations guide
