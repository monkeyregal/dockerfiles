#!/bin/sh

cat <<EOF
FROM java:$JAVA_BASE
MAINTAINER Raymond Kroon <raymond@k3n.nl>

RUN apt-get update && apt-get install -y --no-install-recommends \
		bash \
		git \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir /home/user user \
	&& chown -R user:user /home/user

USER user
WORKDIR /home/user

ENV BOOT_VERSION $BOOT_VERSION
RUN mkdir bin \
    && wget -O bin/boot https://github.com/boot-clj/boot-bin/releases/download/$BOOT_VERSION/boot.sh \
    && chmod +x bin/boot

#preload boot
RUN bin/boot

ENV BOOT_EMIT_TARGET no

#mount points for app and maven cache
WORKDIR /home/user/app
VOLUME /home/user/app /home/user/.m2

ENTRYPOINT ["/home/user/bin/boot"]
EOF
