FROM python:3.10

WORKDIR /home

RUN /bin/bash -c "apt-get update -y;apt-get install wget -y"

RUN wget https://github.com/cdr/code-server/releases/download/3.2.0/code-server-3.2.0-linux-x86_64.tar.gz
RUN tar -xzvf code-server-3.2.0-linux-x86_64.tar.gz

RUN ./code-server-3.2.0-linux-x86_64/code-server --install-extension ms-python.python --force --install-extension ms-azuretools.vscode-docker --force 

CMD /bin/bash -c "./code-server-3.2.0-linux-x86_64/code-server --host 0.0.0.0 --port 8989"
