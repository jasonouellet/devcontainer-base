#!/bin/bash

set -e

echo "🚀 Post-create setup starting..."

# Configure Git
if [ -z "$(git config --global user.name)" ]; then
    echo "📝 Configuring git..."
    git config --global user.name "Developer"
    git config --global user.email "dev@devcontainer.local"
fi

# Initialize Git LFS
echo "📦 Initializing Git LFS..."
git lfs install --system

# Create common directories
echo "📁 Creating common directories..."
mkdir -p /workspace/{src,tests,docs,scripts}

# Initialize Node.js project if needed
if [ ! -f /workspace/package.json ]; then
    echo "📦 Initializing Node.js project..."
    cd /workspace
    npm init -y > /dev/null 2>&1 || true
fi

# Initialize Python virtual environment if needed
if [ ! -d /workspace/venv ]; then
    echo "🐍 Creating Python virtual environment..."
    cd /workspace
    python3 -m venv venv
    echo "✅ Virtual environment created. Activate with: source venv/bin/activate"
fi

# Create .gitignore if it doesn't exist
if [ ! -f /workspace/.gitignore ]; then
    echo "🔒 Creating .gitignore..."
    cat > /workspace/.gitignore << 'EOF'
# Node.js
node_modules/
npm-debug.log*
.npm
yarn-error.log*
pnpm-debug.log*

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST
venv/
ENV/
env/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Environment
.env
.env.local
.env.*.local

# OS
Thumbs.db
.DS_Store

# Build outputs
dist/
build/
*.tgz
EOF
fi

echo "✅ Post-create setup completed!"
echo ""
echo "📌 Quick tips:"
echo "  - Node.js version: $(node --version)"
echo "  - Python version: $(python3 --version)"
echo "  - Activate Python venv: source venv/bin/activate"
echo "  - GitHub CLI: gh auth login"
echo ""
