# devcontainer-base

Custom development container base with multi-language support and advanced developer tools.

## 🎯 Features

- **Multi-language** : Node.js 20, Python 3.11
- **Operating System** : AlmaLinux 9
- **Development Tools** :
  - Docker (client and daemon)
  - Podman (Docker alternative)
  - GitHub CLI
  - Git LFS
  - Build tools (GCC, Make, etc.)
  - Editors (Vim, Nano)
  - System utilities (curl, wget, jq, yq, etc.)

- **VS Code Environment** :
  - Python and TypeScript/Node.js extensions
  - GitHub Copilot and Pull Request support
  - GitLens for Git
  - Docker extension
  
- **Pre-configured ports** : 3000, 5000, 8000, 8080

## 🚀 Quick Start

### Requirements
- Docker and Docker Desktop (with Dev Containers support)
- VS Code with the "Remote - Containers" extension

### Installation

1. **Clone the repository** :
```bash
git clone https://github.com/jasonouellet/devcontainer-base.git
cd devcontainer-base
```

2. **Open in VS Code Dev Container** :
   - Open the folder in VS Code
   - Click the "><" button in the bottom left corner
   - Select "Reopen in Container"

### Or with Docker Compose

```bash
cd .devcontainer
docker-compose up -d
docker-compose exec devcontainer bash
```

## 📦 Included Packages

### Node.js (v20)
- npm, yarn, pnpm
- TypeScript, ts-node
- PM2

### Python (3.11)
- pytest, pytest-cov
- black, flake8, pylint, mypy
- requests, python-dotenv, psutil

## 🔧 Custom Configuration

You can customize the container by modifying :

- `.devcontainer/devcontainer.json` - VS Code Dev Containers configuration
- `.devcontainer/Dockerfile` - Custom Docker image
- `.devcontainer/post-create.sh` - Script executed after container creation

### Build Variables

```json
{
  "args": {
    "NODE_VERSION": "20",
    "PYTHON_VERSION": "3.11"
  }
}
```

## 👤 Default User

- **User** : `developer`
- **Sudo access** : Configured without password
- **Working directory** : `/workspace`

## 🔗 External Resources

- [Use Docker inside a container](https://code.visualstudio.com/docs/devcontainers/containers#_using-docker-from-inside-a-container)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [GitHub CLI Documentation](https://cli.github.com/manual)
- [Git LFS](https://git-lfs.github.com/)

## CI/CD Pipeline

This repository uses separate CI and CD workflows:

- **CI (`ci.yml`)**: Lint, validation, security scanning, build and runtime tests, then candidate image publish (`ci-<sha>`)
- **CD (`cd.yml`)**: Final publication from validated candidate image to release tag and `latest`
- **Guardrail**: Final publish is blocked if `release_tag` is missing
- **Dependabot**: Automatically checks for updates to dependencies

For detailed information, see [CI-CD.md](CI-CD.md).

### Quick Links:
- [View Workflows](../../actions)
- [Published Images](../../pkgs/container/devcontainer-base)
- [Security Alerts](../../security/vulnerability)

## License

See the [LICENSE](LICENSE) file for details.
