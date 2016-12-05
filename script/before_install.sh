#!/usr/bin/env bash

echo "Executing the before_install.sh file"

REGEX_TAG="(.*)-TESTME"
#REGEX_TAG="(.*)-t(.*)"

# Tag condition
if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  sudo rm /usr/local/bin/docker-compose
  curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
  chmod +x docker-compose
  sudo mv docker-compose /usr/local/bin

  docker login -e="$DOCKERHUB_EMAIL" -u="$DOCKERHUB_USER" -p="$DOCKERHUB_PASSWORD";
  chmod +x ./script/bucle_check_url.sh;
  docker-compose up -d & ./script/bucle_check_url.sh;
fi
