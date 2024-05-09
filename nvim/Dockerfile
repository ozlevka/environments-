FROM ubuntu:24.04


ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG LAZYGIT_VERSION="0.41.0" 
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get upgrade \
    && apt-get install -y --no-install-recommends sudo fish jq neovim openssl git \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    && ARCHITECTURE=$(dpkg --print-architecture); if [ "$ARCHITECTURE" = "amd64" ]; then ARCHITECTURE="x86_64"; fi \
    # Install lazygit
    && cd /tmp \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${ARCHITECTURE}.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && install lazygit /usr/local/bin \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    #&& groupadd --gid $USER_GID $USERNAME \
    #&& useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=

WORKDIR /home/${USERNAME}

USER ${USERNAME}


