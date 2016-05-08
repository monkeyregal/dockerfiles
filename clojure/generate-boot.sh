#!/bin/bash

set -e

versions=(
    openjdk-7u101,2.5.2
    openjdk-7u91-alpine,2.5.2
    openjdk-8u72,2.5.2
    openjdk-8u77-alpine,2.5.2
)

for v in "${versions[@]}"
do IFS=","; set $v

   targetdir=$1-boot-$2

   mkdir -p $targetdir

   generate_script=generate-boot-dockerfile.sh
   if [[ $1 == *"alpine"* ]]; then
       generate_script=generate-boot-dockerfile-alpine.sh
   fi

   JAVA_BASE=$1 BOOT_VERSION=$2 ./$generate_script > $targetdir/Dockerfile
done
