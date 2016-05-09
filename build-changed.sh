#!/bin/bash

cd "$(dirname "$0")"

set -e

git_revison="HEAD"
if [[ -n $1 ]]; then
    git_revision=$1
fi

changed_files=( $(git diff-tree --no-commit-id --name-only -r -M $git_revision | grep Dockerfile) )

start_dir=$(pwd)
echo $start_dir

for D in "${changed_files[@]}"
do IFS="/"; set $D
   unset IFS
   cd $1/$2

   echo "Building $1 $2"
   docker build --rm -t monkeyregal/$1:$2 .

   # if [ -n "$PUSH_IMAGE" ]; then
   #     echo "PUSHING"
   #     docker push monkeyregal/$1:$2
   # fi

   cd $start_dir
done
