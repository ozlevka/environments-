FROM python:3.12


ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=ozlevka
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install --no-install-recommends ca-certificates openssh-server wget curl vim \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /home/$USERNAME/.ssh \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh 


COPY dependencies.txt /tmp/depenedencies.txt

RUN pip install -r /tmp/depenedencies.txt

USER ${USERNAME}
WORKDIR /home/${USERNAME}


