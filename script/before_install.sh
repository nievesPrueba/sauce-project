#!/usr/bin/env bash

echo "Executing the before_install.sh file"

REGEX_TAG="(.*)-TESTME"
#REGEX_TAG="(.*)-t(.*)"

# Tag condition
if ! [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  - echo "[WARNING] - Not installed the docker-compose package. Not included -TESTME tag.";
  - exit 0;
fi
