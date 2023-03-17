FROM python:3.10

ARG AZURE_CLI_VERSION=2.42.0
ARG TERRAFORM_VERSION=1.3.4
ARG KUBECTL_VERSION="v1.22.15"
ARG HELM_VERSION="v3.10.2"
ARG KUBELOGIN_VERSION="v0.0.27"



ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends sudo fish jq vim \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    # Install Azure CLI
    && pip install azure-cli==${AZURE_CLI_VERSION} \
    && az extension add --name aks-preview \ 
    # Install Terraform
    && ARCHITECTURE=$(dpkg --print-architecture) \
    && mkdir -p /tmp/terraform && cd /tmp/terraform \
    && curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${ARCHITECTURE}.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_${ARCHITECTURE}.zip \
    && mv terraform /usr/local/bin/terraform && chmod +x /usr/local/bin/terraform \
    && cd / && rm -rf /tmp/terraform \
    # Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCHITECTURE}/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/ \
    # Install Azure kubelogin
    && cd /tmp \
    && curl -LO https://github.com/Azure/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin-linux-${ARCHITECTURE}.zip \
    && unzip kubelogin-linux-${ARCHITECTURE}.zip \
    && mv bin/linux_${ARCHITECTURE}/kubelogin /usr/local/bin/ \
    # Install helm 
    && curl -L -o /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCHITECTURE}.tar.gz \
    && cd /tmp && tar xzf helm.tar.gz \
    && mv linux-${ARCHITECTURE}/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=
