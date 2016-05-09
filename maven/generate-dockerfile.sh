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

ENV MAVEN_VERSION $MAVEN_VERSION

RUN mkdir -p maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC maven --strip-components=1

#mount point for app and maven cache
WORKDIR /home/user/app
VOLUME /home/user/app /home/user/.m2

ENTRYPOINT ["/home/user/maven/bin/mvn"]
EOF
