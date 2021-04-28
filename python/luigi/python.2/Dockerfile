FROM ubuntu:trusty


COPY requirements.txt /

RUN apt-get update \
    && apt-get install -y python python-pip python-dev libssl-dev openssl libffi-dev \
    && pip install "setuptools>=40,<41" \
    && pip install -r requirements.txt