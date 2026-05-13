FROM almalinux:9

# Build arguments
ARG NODE_VERSION=20
ARG PYTHON_VERSION=3.11

# Install system dependencies
RUN dnf update -y && \
    dnf groupinstall -y "Development Tools" && \
    dnf install -y \
    curl \
    wget \
    git \
    git-lfs \
    vim \
    less \
    openssh-clients \
    openssh-server \
    net-tools \
    bind-utils \
    telnet \
    ca-certificates \
    gnupg \
    lsb-release \
    zsh \
    tmux \
    screen \
    htop \
    jq \
    yq \
    unzip \
    zip \
    tar \
    gzip \
    bzip2 \
    xz \
    which \
    sudo \
    && dnf clean all

# Install Python
RUN dnf install -y \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-devel \
    python${PYTHON_VERSION}-pip \
    && dnf clean all

# Set Python 3 symlink
RUN ln -s /usr/bin/python${PYTHON_VERSION} /usr/bin/python3

# Install Node.js using NodeSource repository
RUN curl -fsSL https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    dnf install -y nodejs && \
    dnf clean all

# Install npm packages globally
RUN npm install -g \
    npm@latest \
    yarn \
    pnpm \
    typescript \
    ts-node \
    pm2

# Install Docker CLI
RUN dnf install -y docker && \
    dnf clean all

# Install Podman
RUN dnf install -y podman podman-docker && \
    dnf clean all

# Install GitHub CLI
RUN dnf install -y 'dnf-command(copr)' && \
    dnf copr enable -y heatherw/github-cli && \
    dnf install -y gh && \
    dnf clean all

# Install Git LFS
RUN git lfs install --system

# Create developer user
RUN useradd -m -s /bin/bash developer && \
    usermod -aG wheel,docker,podman developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/developer

# Install commonly used Python packages
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install \
    pytest \
    pytest-cov \
    black \
    flake8 \
    pylint \
    mypy \
    requests \
    python-dotenv \
    psutil

# Switch to developer user
USER developer
WORKDIR /workspace

# Configure shell
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Display version info
RUN echo "=== System Information ===" && \
    echo "Node.js: $(node --version)" && \
    echo "npm: $(npm --version)" && \
    echo "Python: $(python3 --version)" && \
    echo "Git: $(git --version)" && \
    echo "Docker: $(docker --version)" && \
    echo "Podman: $(podman --version)" && \
    echo "GitHub CLI: $(gh --version)" && \
    echo "========================="
