FROM bitnami/spark:3.2.1

USER root

ENV DEBIAN_FRONTEND=noninteractive



RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install --no-install-recommends ca-certificates openssh-server wget curl 


RUN service ssh start


COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

USER 1001

CMD ["/usr/sbin/sshd","-D","-e"]
