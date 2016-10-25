#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test; 
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01; 
  git remote add test-output ssh://nievesSopra@github.com/hello-world.git; 
  git push test-output prueba01; 
fi
