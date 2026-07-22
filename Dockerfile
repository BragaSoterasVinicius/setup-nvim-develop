FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system packages
RUN apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    fd-find \
    git \
    gradle \
    maven \
    openjdk-17-jdk \
    openjdk-21-jdk \
    python3 \
    python3-pip \
    ripgrep \
    software-properties-common \
    sudo \
    tmux \
    unzip \
    wget \
    xz-utils \
    zip \
    zsh \
 && rm -rf /var/lib/apt/lists/*

 
# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
 && apt-get update \
 && apt-get install -y nodejs

# Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
 && tar xzf nvim-linux-x86_64.tar.gz \
 && mv nvim-linux-x86_64 /opt/nvim \
 && rm nvim-linux-x86_64.tar.gz

ENV PATH="/opt/nvim/bin:${PATH}"

# Install Rust (latest)
RUN npm install -g tree-sitter-cli

# Install  Claude
RUN npm install -g @anthropic-ai/claude-code

#Install lazygit
ARG LAZYGIT_VERSION=0.56.0

RUN curl -Lo lazygit.tar.gz \
    "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
 && tar xf lazygit.tar.gz lazygit \
 && install lazygit /usr/local/bin \
 && rm lazygit lazygit.tar.gz

# Create developer user
RUN useradd -ms /bin/bash dev \
 && usermod -aG sudo dev \
 && echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev \
 && chmod 0440 /etc/sudoers.d/dev

RUN mkdir -p \
    /home/dev/.local/share/nvim \
    /home/dev/.local/state/nvim \
    /home/dev/.m2 \
    /home/dev/.gradle \
    /home/dev/.cache \
 && chown -R dev:dev /home/dev

USER dev
WORKDIR /home/dev
