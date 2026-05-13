# Development Container Base - Additional Files

## Project Structure

```
.
├── .devcontainer/           # Dev Container configuration
│   ├── devcontainer.json   # VS Code Dev Containers configuration
│   ├── Dockerfile          # Custom Docker image
│   ├── docker-compose.yml  # Docker Compose configuration
│   ├── post-create.sh      # Post-creation script
│   └── .devcontainerignore # Files to ignore
├── .dockerignore           # Docker ignore files
├── LICENSE                 # Project license
└── README.md               # Documentation
```

## Configuration Files

### devcontainer.json
VS Code Dev Containers configuration with :
- Custom Docker image
- `developer` user with Docker/Podman access
- Pre-configured VS Code extensions
- Pre-configured development ports
- Automatic post-creation script

### Dockerfile
AlmaLinux 9 image with :
- Node.js 20 with npm, yarn, pnpm
- Python 3.11 with scientific packages
- Docker and Podman
- GitHub CLI
- Git LFS
- Development and build tools

### docker-compose.yml
Compose file to start the container without VS Code :
```bash
cd .devcontainer
docker-compose up -d
docker-compose exec devcontainer bash
```

### post-create.sh
Script automatically executed after container creation :
- Git configuration
- Git LFS initialization
- Python virtual environment creation
- Base project structure creation

## Usage

### With VS Code Remote

1. Install the "Remote - Containers" extension
2. Open the folder in VS Code
3. Click "><" in the bottom left
4. "Reopen in Container"

### Directly with Docker

```bash
# Build
docker build -t devcontainer-base:latest -f .devcontainer/Dockerfile .

# Run interactive
docker run -it -v "$(pwd):/workspace" devcontainer-base:latest

# With Docker socket (to use Docker from inside the container)
docker run -it -v "$(pwd):/workspace" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  devcontainer-base:latest
```

### With Docker Compose

```bash
cd .devcontainer
docker-compose up -d
docker-compose exec devcontainer bash
docker-compose down
```

## Customization

### Change Node.js or Python version

Edit `.devcontainer/devcontainer.json` :
```json
"args": {
  "NODE_VERSION": "18",  // or 16, 18, 20, etc.
  "PYTHON_VERSION": "3.10"  // or 3.9, 3.10, 3.11, etc.
}
```

### Add system packages

Modify `.devcontainer/Dockerfile`, section `dnf install -y` :
```dockerfile
RUN dnf install -y \
    existing-packages \
    new-package \
    another-package
```

### Add Node.js packages globally

Modify `.devcontainer/Dockerfile`, line `npm install -g` :
```dockerfile
RUN npm install -g \
    existing-packages \
    new-package
```

### Add Python packages globally

Modify `.devcontainer/Dockerfile`, line `python3 -m pip install` :
```dockerfile
RUN python3 -m pip install \
    existing-packages \
    new-package
```

### Add VS Code extensions

Modify `.devcontainer/devcontainer.json`, section `extensions` :
```json
"extensions": [
  "existing-extensions",
  "publisher.new-extension"
]
```

## Troubleshooting

### Docker socket permission denied

Make sure the Docker socket mount is configured :
```json
"mounts": [
  "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
]
```

### Git LFS not working

Verify that Git LFS is initialized :
```bash
git lfs install
```

### Permission denied on post-create.sh

Make the script executable :
```bash
chmod +x .devcontainer/post-create.sh
```

## Support

For any questions or issues, consult :
- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker Documentation](https://docs.docker.com/)
- [GitHub CLI Documentation](https://cli.github.com/manual)
