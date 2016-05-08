#!/bin/bash

set -e

versions=(
    openjdk-6b38
    openjdk-7u101
    openjdk-7u91-alpine
    openjdk-8u72
    openjdk-8u77-alpine
)

for v in "${versions[@]}"
do
   targetdir=$v

   mkdir -p $targetdir

   generate_script=generate-dockerfile.sh
   if [[ $v == *"alpine"* ]]; then
       generate_script=generate-dockerfile-alpine.sh
   fi

   JAVA_BASE=$v ./$generate_script > $targetdir/Dockerfile
done
