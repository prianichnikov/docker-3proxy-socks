FROM alpine:3.12 as build

RUN apk update && apk add --no-cache build-base linux-headers bind-tools

RUN mkdir -p /usr/src 
WORKDIR /usr/src
RUN wget -q https://github.com/z3APA3A/3proxy/archive/0.8.13.tar.gz -O - | tar zxf -
WORKDIR /usr/src/3proxy-0.8.13

RUN make -f Makefile.Linux && \ 
    make -f Makefile.Linux install

FROM alpine:3.12

COPY --from=build /usr/local /usr/local

ADD 3proxy.cfg /usr/local/etc/3proxy/3proxy.cfg
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENV USER=socks
ENV PASSWORD=

EXPOSE 1080

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["start"]