# Examples - Using devcontainer-base

This directory contains examples of how to use the devcontainer-base image in your own projects.

## Example 1: Basic Node.js Project

```json
{
  "name": "My Node.js Project",
  "image": "ghcr.io/jasonouellet/devcontainer-base:latest",
  "mounts": [
    "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
  ],
  "customizations": {
    "vscode": {
      "extensions": ["ms-vscode.vscode-typescript-next"]
    }
  },
  "forwardPorts": [3000],
  "postCreateCommand": "npm install"
}
```

## Example 2: Python Data Science Project

```json
{
  "name": "Data Science Project",
  "image": "ghcr.io/jasonouellet/devcontainer-base:latest",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-python.jupyter"
      ],
      "settings": {
        "python.defaultInterpreterPath": "/usr/bin/python3"
      }
    }
  },
  "postCreateCommand": "pip install jupyter pandas numpy scikit-learn"
}
```

## Example 3: Full Stack Project (Node.js + Python)

```json
{
  "name": "Full Stack Project",
  "image": "ghcr.io/jasonouellet/devcontainer-base:latest",
  "mounts": [
    "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
  ],
  "forwardPorts": [3000, 5000, 8000],
  "portsAttributes": {
    "3000": {"label": "Frontend", "onAutoForward": "notify"},
    "5000": {"label": "Backend", "onAutoForward": "notify"},
    "8000": {"label": "API", "onAutoForward": "notify"}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-vscode.vscode-typescript-next",
        "ms-python.python",
        "eamodio.gitlens"
      ]
    }
  },
  "postCreateCommand": "bash -c 'npm install && pip install -r requirements.txt'"
}
```

## Example 4: Using Docker Compose

```yaml
version: '3.8'

services:
  devcontainer:
    image: ghcr.io/jasonouellet/devcontainer-base:latest
    container_name: my-project-dev
    volumes:
      - .:/workspace
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - "3000:3000"
      - "5000:5000"
      - "8000:8000"
    stdin_open: true
    tty: true
    working_dir: /workspace
    
  # Optional: Add additional services
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: mydb
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  # Optional: Add Redis
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

## Example 5: GitHub Workflow Using the Image

```yaml
name: Build with devcontainer-base

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/jasonouellet/devcontainer-base:latest
      credentials:
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}

    steps:
      - uses: actions/checkout@v4

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Run Python tests
        run: python3 -m pytest
```

## Example 6: Extending the Base Image

If you need to extend devcontainer-base with additional tools:

```dockerfile
FROM ghcr.io/jasonouellet/devcontainer-base:latest

# Add additional system packages
RUN dnf install -y \
    postgresql-client \
    mysql-client \
    sqlite

# Add additional Node.js tools
RUN npm install -g \
    @angular/cli \
    create-react-app

# Add additional Python packages
RUN python3 -m pip install \
    django \
    djangorestframework \
    celery

# Custom setup
USER developer
WORKDIR /workspace
```

## Example 7: Local Development with Volume Mounts

```bash
# Create a devcontainer.json for your project
cat > .devcontainer/devcontainer.json << 'EOF'
{
  "name": "My Project",
  "image": "ghcr.io/jasonouellet/devcontainer-base:latest",
  "mounts": [
    "source=${localEnv:HOME}/.ssh,target=/home/developer/.ssh,type=bind,readonly"
  ],
  "postCreateCommand": "npm install"
}
EOF

# Start in VS Code
code .
# Then "Reopen in Container"
```

## Example 8: Multiple Node/Python Versions

If you need a specific version tag:

```bash
# Pull a specific version
docker pull ghcr.io/jasonouellet/devcontainer-base:v1.0.0

# Use in devcontainer.json
{
  "image": "ghcr.io/jasonouellet/devcontainer-base:v1.0.0"
}

# Or use a branch
docker pull ghcr.io/jasonouellet/devcontainer-base:feature-first-version
```

## Tips & Best Practices

### 1. Always Pin Versions
```json
{
  "image": "ghcr.io/jasonouellet/devcontainer-base:v1.0.0"
  // Instead of :latest
}
```

### 2. Use Specific Ports
```json
{
  "forwardPorts": [3000],  // Not wildcard
  "portsAttributes": {
    "3000": {
      "label": "Application",
      "onAutoForward": "notify"
    }
  }
}
```

### 3. Keep Post-Create Scripts Simple
```bash
# Good: Single, focused command
"postCreateCommand": "npm install"

# Avoid: Complex multi-line scripts
# Use separate script files instead
"postCreateCommand": "bash scripts/setup.sh"
```

### 4. Use .devcontainerignore
```
.git
.gitignore
node_modules
venv
__pycache__
.env
```

### 5. Document Your Setup
```markdown
# Development Setup

## Using Dev Container

Open in VS Code and click "Reopen in Container"

## Using Docker Compose

```bash
docker-compose up -d
docker-compose exec dev bash
```
```

## Troubleshooting Examples

### Image not found
```bash
# Pull the image first
docker pull ghcr.io/jasonouellet/devcontainer-base:latest
```

### Permission denied on docker socket
```json
{
  "mounts": [
    "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
  ]
}
```

### Package manager issues
```bash
# Update package lists
npm cache clean --force
pip cache purge

# Reinstall
npm install
pip install -r requirements.txt
```

## More Examples

See the main repository for:
- [CI/CD Integration](../CI-CD.md)
- [Development Container Configuration](../DEVCONTAINER.md)
- [Contribution Guidelines](../CONTRIBUTING.md)

## Questions?

Check the [CI-CD.md](../CI-CD.md) documentation or open a GitHub issue.
