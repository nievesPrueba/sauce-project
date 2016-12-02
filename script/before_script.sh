#!/usr/bin/env bash

echo "Executing the before_script.sh file"

REGEX_TAG="(.*)-TESTME"
#REGEX_TAG="(.*)-t(.*)"

# Tag condition
if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  docker login -e="$DOCKERHUB_EMAIL" -u="$DOCKERHUB_USER" -p="$DOCKERHUB_PASSWORD";
  chmod +x ./script/bucle_check_url.sh;
  docker-compose stop;
  docker-compose up & ./script/bucle_check_url.sh;
fi
