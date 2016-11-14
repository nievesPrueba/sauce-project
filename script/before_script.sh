#!/usr/bin/env bash

echo "Executing the before_script.sh file"

REGEX_TAG="(.*)-TESTME"
#REGEX_TAG="(.*)-t(.*)"

# Tag condition
if ! [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  - echo "[WARNING] - Not displayed the docker-compose package, the application is down. Not included -TESTME tag.";
  - exit 0;
fi
