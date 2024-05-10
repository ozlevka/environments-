FROM ubuntu:24.04


ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG LAZYGIT_VERSION="0.41.0" 
ARG NEOVIM_VERSION="v0.9.5"
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get upgrade \
    && apt-get install -y --no-install-recommends sudo fish openssl git openssh-client \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    python3 python3-dev python3-pip nodejs npm fontconfig unzip gcc g++ \
    && ARCHITECTURE=$(dpkg --print-architecture); if [ "$ARCHITECTURE" = "amd64" ]; then ARCHITECTURE="x86_64"; fi \
    # Install lazygit
    && cd /tmp \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${ARCHITECTURE}.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && install lazygit /usr/local/bin \
    && curl -LO https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux64.tar.gz \
    && tar -C /opt -xzf nvim-linux64.tar.gz \
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
ENV PATH="$PATH:/opt/nvim-linux64/bin"

WORKDIR /home/${USERNAME}

USER ${USERNAME}

RUN mkdir -p ~/.local/share/fonts \
    && mkdir -p ~/.config/nvim \
    && cd  ~/.local/share/fonts \ 
    && curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip \
    && unzip JetBrainsMono.zip \ 
    && rm *.zip \
    && fc-cache -fv \
    && cd \
    && git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim




