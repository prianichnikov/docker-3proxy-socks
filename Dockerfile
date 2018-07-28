###
# Build stage
###

FROM alpine:3.8 as build

RUN apk update && apk add build-base linux-headers bind-tools

RUN mkdir -p /usr/src 
WORKDIR /usr/src
RUN wget -q https://github.com/z3APA3A/3proxy/archive/0.8.12.tar.gz -O - | tar zxf -
WORKDIR /usr/src/3proxy-0.8.12

RUN make -f Makefile.Linux && \ 
    make -f Makefile.Linux install

###
# Prepare stage
###

FROM alpine:3.8
LABEL maintainer="Maksim Prianichnikov"

COPY --from=build /usr/local /usr/local

RUN echo -e \
"nscache 65536 \n\
nserver 1.1.1.1 \n\
nserver 8.8.8.8 \n\
log \n\
logformat \"L%d-%m-%Y %H:%M:%S %z %E %U %C:%c %R:%r %O %I %h %T\" \n\
users _USER_:CL:_PASSWORD_ \n\
auth strong \n\
allow _USER_ \n\
maxconn 200 \n\
flush \n\
socks -4" > /usr/local/etc/3proxy/3proxy.cfg

ADD docker-entrypoint.sh /usr/local

ENV PASSWORD=
ENV USER=socks

EXPOSE 1080

CMD /bin/sh /usr/local/docker-entrypoint.sh
