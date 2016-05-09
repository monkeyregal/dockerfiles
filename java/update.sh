#!/bin/bash

cd "$(dirname "$0")"
set -e

versions=(
    openjdk-6
    openjdk-7
    openjdk-7-alpine
    openjdk-8
    openjdk-8-alpine
)

for v in "${versions[@]}"
do
   targetdir=$v

   mkdir -p $targetdir

   current_version=
   [[ -f $targetdir/VERSION ]] && current_version=$(cat $targetdir/VERSION)
   docker pull java:$v
   export $(docker inspect --type image --format='{{range .Config.Env }}{{println .}}{{end}}'  java:$v | grep "^JAVA_VERSION")

   # Only generate when base image version is updated
   if [[ $current_version != $JAVA_VERSION ]]; then

       echo "Updating $v to $JAVA_VERSION"

       printf "$JAVA_VERSION" > $targetdir/VERSION

       generate_script=generate-dockerfile.sh
       if [[ $v == *"alpine"* ]]; then
           generate_script=generate-dockerfile-alpine.sh
       fi

       JAVA_BASE=$v ./$generate_script > $targetdir/Dockerfile
   fi
done
