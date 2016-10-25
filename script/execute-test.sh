#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test;
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;
  git remote -v
#  git remote add test-output https://nievesSopra:24ca3b0580115685d9e5bc31034c410d397dbae3@github.com/nievesSopra/hello-world.git; 
  git remote add test-output https://24ca3b0580115685d9e5bc31034c410d397dbae3@github.com/nievesSopra/hello-world.git; 
  git push test-output prueba01; 
#fi
