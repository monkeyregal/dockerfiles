FROM java:openjdk-8u77-alpine
MAINTAINER Raymond Kroon <raymond@k3n.nl>

RUN apk add --update bash git && rm -rf /var/cache/apk/*
RUN adduser -D -h /home/user user

USER user
WORKDIR /home/user

RUN mkdir bin     && wget -O bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.6.1/bin/lein     && chmod +x bin/lein

#preload leiningen
RUN bin/lein

#mount points for app and maven cache
WORKDIR /home/user/app
VOLUME /home/user/app /home/user/.m2

ENTRYPOINT ["/home/user/bin/lein"]
