FROM python:3.10

ENV DEBIAN_FRONTEND=noninteractive
ARG AZURE_CLI_VERSION=2.42.0
ARG ARGOCD_VERSION="v2.6.0-rc7"

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    && pip install azure-cli==${AZURE_CLI_VERSION} \
    && curl -LO https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64 \
    && mv argocd-linux-amd64 /usr/local/bin/argocd \
    && chmod +x /usr/local/bin/argocd 



