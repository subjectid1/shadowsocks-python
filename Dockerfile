FROM ubuntu:18.04
MAINTAINER isymbo<isymbo@gmail.com>

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD    password
ENV METHOD      chacha20-ietf-poly1305
ENV TIMEOUT     300

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y python-pip git && \
    pip install --upgrade pip && \
    rm -rf /var/lib/apt/lists/*
RUN pip install git+https://github.com/shadowsocks/shadowsocks.git@master

EXPOSE $SERVER_PORT/tcp $SERVER_PORT/udp

CMD /usr/local/bin/ssserver \
        --fast-open \
        -s $SERVER_ADDR \
        -p $SERVER_PORT \
        -k $PASSWORD \
        -m $METHOD \
        -t $TIMEOUT
