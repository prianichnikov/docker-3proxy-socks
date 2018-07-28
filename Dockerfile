###
# Build 3proxy
###

FROM alpine:3.8 as build

RUN apk update && apk add --no-cache build-base linux-headers bind-tools

RUN mkdir -p /usr/src 
WORKDIR /usr/src
RUN wget -q https://github.com/z3APA3A/3proxy/archive/0.8.12.tar.gz -O - | tar zxf -
WORKDIR /usr/src/3proxy-0.8.12

RUN make -f Makefile.Linux && \ 
    make -f Makefile.Linux install

###
# Prepare image
###

FROM alpine:3.8
LABEL maintainer="Maksim Prianichnikov"

COPY --from=build /usr/local /usr/local

ADD 3proxy.cfg /usr/local/etc/3proxy/3proxy.cfg
ADD docker-entrypoint.sh /usr/local

ENV USER=socks
ENV PASSWORD=

EXPOSE 1080

CMD /bin/sh /usr/local/docker-entrypoint.sh
