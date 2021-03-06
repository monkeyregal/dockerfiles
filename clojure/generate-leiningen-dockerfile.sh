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

RUN mkdir bin \
    && wget -O bin/lein https://raw.githubusercontent.com/technomancy/leiningen/$LEIN_VERSION/bin/lein \
    && chmod +x bin/lein

#preload leiningen
RUN bin/lein

#mount points for app and maven cache
WORKDIR /home/user/app
VOLUME /home/user/app /home/user/.m2

ENTRYPOINT ["/home/user/bin/lein"]
EOF
