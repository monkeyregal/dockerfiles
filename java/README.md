How to use
======

Make an alias like `alias java="docker run --rm -ti -v $PWD:/home/user/app -v --net host monkeyregal/java:openjdk-8-alpine"`

Preferably take the alpine versions, since they are smaller. If you cannot use Alpine linux (they have a different libc), then use the not Alpine version.
