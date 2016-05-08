#!/bin/bash

set -e

for D in *; do

   [[ -d "${D}" ]] && docker build --rm -t monkeyregal/lein:$D .

done
