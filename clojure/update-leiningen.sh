#!/bin/bash

cd "$(dirname "$0")"
set -e

versions=(
    openjdk-6,2.6.1
    openjdk-7,2.6.1
    openjdk-7-alpine,2.6.1
    openjdk-8,2.6.1
    openjdk-8-alpine,2.6.1
)

for v in "${versions[@]}"
do IFS=","; set $v

   targetdir=$1-leiningen-$2

   mkdir -p $targetdir

   java_current_version=
   [[ -f $targetdir/JAVA_VERSION ]] && java_current_version=$(cat $targetdir/JAVA_VERSION)
   docker pull java:$1
   export $(docker inspect --type image --format='{{range .Config.Env }}{{println .}}{{end}}'  java:$1 | grep "^JAVA_VERSION")

   leiningen_current_version=
   [[ -f $targetdir/LEININGEN_VERSION ]] && leiningen_current_version=$(cat $targetdir/LEININGEN_VERSION)

   # Only generate when versions are updated
   if [[ $java_current_version != $JAVA_VERSION || $leiningen_current_version != $2 ]]; then

       echo "Updating $1,$2 to $JAVA_VERSION"

       printf "$JAVA_VERSION" > $targetdir/JAVA_VERSION
       printf "$2" > $targetdir/LEININGEN_VERSION

       generate_script=generate-leiningen-dockerfile.sh
       if [[ $1 == *"alpine"* ]]; then
           generate_script=generate-leiningen-dockerfile-alpine.sh
       fi

       JAVA_BASE=$1 LEIN_VERSION=$2 ./$generate_script > $targetdir/Dockerfile
   fi
done
