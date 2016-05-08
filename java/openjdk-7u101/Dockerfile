FROM java:openjdk-7u101
MAINTAINER Raymond Kroon <raymond@k3n.nl>

RUN apt-get update && apt-get install -y --no-install-recommends 		bash 		git 	&& rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir /home/user user 	&& chown -R user:user /home/user

USER user
WORKDIR /home/user

#mount point for app
WORKDIR /home/user/app
VOLUME /home/user/app

ENTRYPOINT ["java"]
