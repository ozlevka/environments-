FROM python:3.12.2-bookworm

ARG KUBECTL_VERSION="v1.27.5"
ARG HELM_VERSION="v3.13.2"
ARG LINODE_API_VERSION="5.10.0"
ARG LINODE_CLI_VERSION="5.45.2"
ARG YQ_VERSION="v4.35.2"
ARG JINJA2_LIBRARY_VERSION="3.1.2"
ARG PY_KUBERNETES_VERSION="28.1.0"
ARG PY_ELASTICSEARCH_VERSION="8.11.0"
ARG ARGO_VERSION="3.5.2"
ARG OS="linux"

ARG USERNAME=devops
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends fish jq  \
    apt-transport-https \
    ca-certificates \
    apt-utils dialog \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    && apt-get -y install --no-install-recommends ca-certificates openssh-server wget \
    && pip install jinja2==${JINJA2_LIBRARY_VERSION} linode-api4==${LINODE_API_VERSION}  linode-cli==${LINODE_CLI_VERSION} kubernetes==${PY_KUBERNETES_VERSION} \ 
       elasticsearch==${PY_ELASTICSEARCH_VERSION} \ 
    && ARCHITECTURE=$(dpkg --print-architecture) \
    # Install kubectl
    && curl -sLO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/${OS}/${ARCHITECTURE}/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/ \
    # Install helm 
    && curl -sL -o /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-${OS}-${ARCHITECTURE}.tar.gz \
    && cd /tmp && tar xzf helm.tar.gz \
    && mv ${OS}-${ARCHITECTURE}/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm \
    # Install yq
    && curl -L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_${OS}_${ARCHITECTURE} -o /usr/bin/yq \
    && chmod +x /usr/bin/yq \
    # install argo-cli
    && curl -sL -o /tmp/argo.gz "https://github.com/argoproj/argo-workflows/releases/download/v${ARGO_VERSION}/argo-${OS}-${ARCHITECTURE}.gz" \
    && cd /tmp && gunzip argo.gz \
    && mv argo /usr/local/bin/argo && chmod +x /usr/local/bin/argo \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN service ssh start

COPY sshd_config /etc/ssh/sshd_config

ENV DEBIAN_FRONTEND=

EXPOSE 22
