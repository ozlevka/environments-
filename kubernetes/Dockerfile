FROM python:3.10

ARG USERNAME=kube
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG KUBECTL_VERSION="v1.24.9"
ARG HELM_VERSION="v3.10.2"


RUN ARCHITECTURE=$(dpkg --print-architecture) \
    # Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCHITECTURE}/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/ \
    # Install helm 
    && curl -L -o /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCHITECTURE}.tar.gz \
    && cd /tmp && tar xzf helm.tar.gz \
    && mv linux-${ARCHITECTURE}/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME


USER kube 
WORKDIR /home/kube
