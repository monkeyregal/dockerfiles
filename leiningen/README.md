Using
======

Make an alias like `alias lein="docker run --rm -ti -v $PWD:/home/user/app -v $HOME/.m2:/home/user/.m2 --net host monkeyregal/lein:openjdk-8u77-alpine-2.6.1"`

Preferably take the alpine versions, since they are smaller. If you cannot use Alpine linux (they have a different libc), then use the not Alpine version.
