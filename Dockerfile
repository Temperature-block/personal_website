FROM ubuntu:latest

# Setting the working directory to /app
WORKDIR /website

COPY . /website

# Getting the updates for Ubuntu and installing python into our environment
RUN apt-get -y update  && apt-get install -y hugo

RUN hugo

RUN cd ./public

RUN wget https://caddyserver.com/api/download?os=linux&arch=amd64&idempotency=3167728520201

RUN chmod +x caddy*

CMD ["./caddy*", "file-server"]
