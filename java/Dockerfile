FROM python:3.11.4



RUN deb http://deb.debian.org/debian/ bullseye-updates main \
    && deb-src http://deb.debian.org/debian/ bullseye-updates main \
    && apt-get update \
    && apt-get -y install openjdk-11-jdk
