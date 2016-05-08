FROM java:openjdk-7u91-alpine
MAINTAINER Raymond Kroon <raymond@k3n.nl>

RUN apk add --update bash git ca-certificates     && update-ca-certificates     && rm -rf /var/cache/apk/*

RUN find /etc/ssl/certs/ -name "*.crt" -o -name "*.pem" -exec keytool -importcert -file {} -keystore $JAVA_HOME/jre/lib/security/cacerts -noprompt -storepass changeit -alias {} \;

RUN adduser -D -h /home/user user

USER user
WORKDIR /home/user

ENV BOOT_VERSION 2.5.2
RUN mkdir bin     && wget -O bin/boot https://github.com/boot-clj/boot-bin/releases/download/2.5.2/boot.sh     && chmod +x bin/boot

#preload boot
RUN bin/boot

ENV BOOT_EMIT_TARGET no

#mount points for app and maven cache
WORKDIR /home/user/app
VOLUME /home/user/app /home/user/.m2

ENTRYPOINT ["/home/user/bin/boot"]
