FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive
ARG AZURE_CLI_VERSION=2.44.1
ARG ARGOCD_VERSION="v2.6.0"
ARG KUBECTL_VERSION="v1.24.9"
ARG HELM_VERSION="v3.10.2"

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && pip install azure-cli==${AZURE_CLI_VERSION} \
    # Get ARchitecture
    && ARCHITECTURE=$(dpkg --print-architecture) \
    && curl -LO https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-${ARCHITECTURE} \
    && mv argocd-linux-amd64 /usr/local/bin/argocd \
    && chmod +x /usr/local/bin/argocd \
    # Install kubectl
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCHITECTURE}/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/bin/ \
    # Install helm 
    && curl -L -o /tmp/helm.tar.gz https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCHITECTURE}.tar.gz \
    && cd /tmp && tar xzf helm.tar.gz \
    && mv linux-${ARCHITECTURE}/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm



