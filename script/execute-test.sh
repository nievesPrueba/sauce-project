#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test; 
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01; 
  git remote add test-output https://nievesSopra:da3c9ff133a3f5ce0c0546100e4df518ec7dfeeb@github.com/nievesSopra/hello-world.git; 
  git push test-output prueba01; 
fi
