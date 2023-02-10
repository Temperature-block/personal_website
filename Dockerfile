FROM ubuntu:latest

# Setting the working directory to /app
WORKDIR /website

COPY . /website

# Getting the updates for Ubuntu and installing python into our environment
RUN apt-get -y update  && apt-get install -y hugo

RUN hugo

RUN wget https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=3167728520201

RUN ls

RUN  apt install -y debian-keyring debian-archive-keyring apt-transport-https

RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

RUN apt update

RUN apt install caddy

CMD ["caddy file-server --root ./public*"]
