#!/bin/bash

cd "$(dirname "$0")"
set -e

versions=(
    openjdk-7,3.3.9
    openjdk-7-alpine,3.3.9
    openjdk-8,3.3.9
    openjdk-8-alpine,3.3.9
)

for v in "${versions[@]}"
do IFS=","; set $v

   targetdir=$1-maven-$2

   mkdir -p $targetdir

   java_current_version=
   [[ -f $targetdir/JAVA_VERSION ]] && java_current_version=$(cat $targetdir/JAVA_VERSION)
   docker pull java:$1
   export $(docker inspect --type image --format='{{range .Config.Env }}{{println .}}{{end}}'  java:$1 | grep "^JAVA_VERSION")

   maven_current_version=
   [[ -f $targetdir/MAVEN_VERSION ]] && maven_current_version=$(cat $targetdir/MAVEN_VERSION)

   # Only generate when versions are updated
   if [[ -n $FORCE_UPDATE ||  $java_current_version != $JAVA_VERSION || $maven_current_version != $2 ]]; then

       echo "Updating $1,$2 to $JAVA_VERSION"

       printf "$JAVA_VERSION" > $targetdir/JAVA_VERSION
       printf "$2" > $targetdir/MAVEN_VERSION

       generate_script=generate-dockerfile.sh
       if [[ $1 == *"alpine"* ]]; then
           generate_script=generate-dockerfile-alpine.sh
       fi

       JAVA_BASE=$1 MAVEN_VERSION=$2 ./$generate_script > $targetdir/Dockerfile
   fi
done
