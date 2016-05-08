#!/bin/bash

set -e

versions=(
    openjdk-6b38,2.6.1
    openjdk-7u101,2.6.1
    openjdk-7u91-alpine,2.6.1
    openjdk-8u72,2.6.1
    openjdk-8u77-alpine,2.6.1
)

for v in "${versions[@]}"
do IFS=","; set $v

   targetdir=$1-leiningen-$2

   mkdir -p $targetdir

   generate_script=generate-dockerfile.sh
   if [[ $1 == *"alpine"* ]]; then
       generate_script=generate-dockerfile-alpine.sh
   fi

   JAVA_BASE=$1 LEIN_VERSION=$2 ./$generate_script > $targetdir/Dockerfile
done
