# Repository Configuration Summary

## 📋 Quick Reference

### Key Files
- **Dockerfile**: AlmaLinux 9 with Node.js 20 + Python 3.11
- **devcontainer.json**: VS Code Dev Container configuration
- **post-create.sh**: Automated setup script
- **CI/CD Workflows**: GitHub Actions for build, test, security, and publish

### Published Artifacts
- **Docker Image**: `ghcr.io/jasonouellet/devcontainer-base`
- **Versions**: Semantic versioning with git tags
- **Platforms**: Linux AMD64 (Intel/AMD) and ARM64 (Apple Silicon)

## 🚀 Getting Started for Maintainers

### Building Locally
```bash
# Build for current platform
docker build -t devcontainer-base:local -f .devcontainer/Dockerfile .

# Build for multiple platforms (requires buildx)
docker buildx build --platform linux/amd64,linux/arm64 -t devcontainer-base:multi -f .devcontainer/Dockerfile .
```

### Testing Locally
```bash
# Run tests manually
docker run --rm devcontainer-base:local npm --version
docker run --rm devcontainer-base:local python3 --version
docker run --rm devcontainer-base:local docker --version
docker run --rm devcontainer-base:local gh --version
```

### Publishing a Release
```bash
# Tag a new version
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push the tag (triggers CI workflow)
git push origin v1.0.0

# View workflow status in Actions tab
```

## 📊 Workflow Status

Monitor workflows in the **Actions** tab:
- **Build and Push**: Main pipeline for building and publishing images
- **Lint**: Code quality checks
- **Security Scan**: Vulnerability assessment

## 🔐 Security

### Image Security
- Regular updates via Dependabot
- Trivy scanning for vulnerabilities
- Dockerfile best practices via Hadolint

### Repository Security
- Branch protection on main
- Code review required (via CODEOWNERS)
- Security alerts monitored

## 📦 Dependencies

### Automated Updates
Dependabot automatically checks for:
- **GitHub Actions**: Weekly updates
- **Docker base image**: Monthly updates

### Manual Updates
To manually update versions:
1. Edit `.devcontainer/Dockerfile`
2. Update version numbers
3. Create a PR for review
4. Merge after CI passes

## 🛠️ Common Tasks

### Add a new Python package
Edit `.devcontainer/Dockerfile` and add to:
```dockerfile
RUN python3 -m pip install \
    existing-packages \
    new-package
```

### Add a new Node.js package globally
Edit `.devcontainer/Dockerfile` and add to:
```dockerfile
RUN npm install -g \
    existing-packages \
    new-package
```

### Add a VS Code extension
Edit `.devcontainer/devcontainer.json`:
```json
"extensions": [
  "existing.extension",
  "publisher.new-extension"
]
```

### Change Node.js or Python version
Edit `.devcontainer/devcontainer.json`:
```json
"args": {
  "NODE_VERSION": "20",
  "PYTHON_VERSION": "3.11"
}
```

## 📝 Documentation

### Main Documentation
- **README.md**: Quick start and features
- **DEVCONTAINER.md**: Detailed configuration
- **CI-CD.md**: Workflow documentation
- **CONTRIBUTING.md**: Contribution guidelines

### GitHub Configuration
- **.github/README.md**: GitHub directory content
- **.github/CODEOWNERS**: Code ownership rules
- **.github/dependabot.yml**: Update automation

## ✅ Pre-Release Checklist

Before creating a release:

- [ ] Update README.md with changes
- [ ] Update DEVCONTAINER.md if configuration changed
- [ ] Update CI-CD.md if workflows changed
- [ ] Run `docker build` to verify no errors
- [ ] Test key components locally
- [ ] Verify all workflows pass
- [ ] Review security scan results
- [ ] Update CHANGELOG (if maintaining one)
- [ ] Create git tag with proper version
- [ ] Push tag to trigger publishing

## 📞 Support Channels

- **Issues**: GitHub Issues for bugs and features
- **Discussions**: GitHub Discussions for questions
- **Security**: GitHub Security tab for alerts

## 🔗 External Links

- [GitHub Container Registry](https://github.com/jasonouellet/devcontainer-base/pkgs/container/devcontainer-base)
- [Actions Workflows](https://github.com/jasonouellet/devcontainer-base/actions)
- [Security Alerts](https://github.com/jasonouellet/devcontainer-base/security/alerts)
- [Repository Settings](https://github.com/jasonouellet/devcontainer-base/settings)

## 🎓 Learning Resources

### Docker & Containers
- [Docker Documentation](https://docs.docker.com/)
- [Docker Buildx](https://docs.docker.com/build/architecture/)
- [Best practices for Dockerfiles](https://docs.docker.com/develop/dev-best-practices/)

### GitHub Actions
- [Introduction to GitHub Actions](https://docs.github.com/en/actions/learn-github-actions)
- [Workflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Security best practices](https://docs.github.com/en/actions/security-guides)

### Dev Containers
- [Dev Containers specification](https://containers.dev/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)

---

**Last Updated**: May 13, 2026
