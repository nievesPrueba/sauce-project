#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test;
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;
  #curl https://api.github.com/?access_token=${TRAVIS_TOKEN};

  git add -f prueba01;
  echo "add prueba01";
  git commit -m "esto es una prueba";
  echo "commit";
  git status;
  echo "status";
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/nievesSopra/hello-world.git;
  echo "remote add";
  git remote -v;
  echo "remote -v"
  git push test-output master;
  echo "push";
#fi
