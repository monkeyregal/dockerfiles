#!/usr/bin/env bash

set -e

echo "Update Java" && java/update.sh
echo "Update Leiningen" && clojure/update-leiningen.sh
echo "Update Boot" && clojure/update-boot.sh
echo "Update Maven" && maven/update.sh
