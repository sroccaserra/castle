FROM alpine:3.9

RUN apk add --update \
    musl-dev gcc ca-certificates curl unzip \
    lua5.2 lua5.2-dev luarocks5.2

RUN ln -s /usr/bin/lua5.2 /usr/bin/lua \
    && ln -s /usr/bin/luarocks-5.2 /usr/bin/luarocks

RUN USER=root luarocks install busted
