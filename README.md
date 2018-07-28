# 3proxy socks server docker image

Docker image of 3proxy socks server.

## Three simple steps for the run socks proxy server

1. Run the container:

```bash
docker run -d \
-p 5555:1080 \
--name 3proxy-socks \
prianichnikov/3proxy-socks
```

2. Check the password:

```bash
docker logs 3proxy-socks
```

Login and password will be printed to the log during starting the proxy server.  
**By default username is "socks" and password will be generated randomly,** for example:

```bash
--------------------------------------------------
Proxy user login:         socks
Proxy user password:      kd5Idval5hr91
--------------------------------------------------
```

3. Proxy server will be ready for using on the port 5555/TCP, enjoy :)

## Define own username and password

If you want to define own username and password sipmly set environment variables USER and PASSWORD during starting the container.

```bash
docker run -d \
-p 5555:1080 \
-e USER=user \
-e PASSWORD=Aiphah8Aul \
--name 3proxy-socks \
prianichnikov/3proxy-socks
```

Your's username and password will be printed to the log:

```bash
--------------------------------------------------
Proxy user login:         user
Proxy user password:      Aiphah8Aul
--------------------------------------------------
```