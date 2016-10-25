#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test;
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;
  git status;
  #curl https://api.github.com/?access_token=${TRAVIS_TOKEN};
  git add .;
  git commit -a;
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/nievesSopra/hello-world.git; 
  git push test-output prueba01;
#fi
