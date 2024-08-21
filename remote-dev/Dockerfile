FROM debian:bullseye-20220622

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install --no-install-recommends openssh-server curl wget vim git \
    # Install not root user
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME  \
    && service ssh start \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
COPY ./id_rsa.pub /home/${USERNAME}/.ssh/
COPY sshd_config /etc/ssh/

RUN mv /home/${USERNAME}/.ssh/id_rsa.pub /home/${USERNAME}/.ssh/authorized_keys \
    && chown -R 1000:1000 /home/${USERNAME}/.ssh/ \
    && chmod 0600 /home/${USERNAME}/.ssh/authorized_keys

ENV DEBIAN_FRONTEND=

ENTRYPOINT [ "/entrypoint.sh" ]
