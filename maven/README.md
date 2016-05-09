How to use
======

Make an alias like `alias mvn='docker run --rm -ti -v $PWD:/home/user/app -v $HOME/.m2:/home/user/.m2 --net host monkeyregal/maven:openjdk-8-alpine-maven-3.3.9'`

Preferably take the alpine versions, since they are smaller. If you cannot use Alpine linux (they have a different libc), then use the not Alpine version.
