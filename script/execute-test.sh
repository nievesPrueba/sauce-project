#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  mvn test;
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;
  #curl https://api.github.com/?access_token=${TRAVIS_TOKEN};

  # Create the new branch (branch01) and add the folder
  git init;
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/nievesSopra/hello-world.git;
  git checkout -b branch01;
  git add -f prueba01;
  git commit -m "esto es una prueba";
  git push -u test-output branch01;

  #Merge branch01 into master branch:
  git fetch;
  git checkout -f master;
  git merge --allow-unrelated-histories branch01;
  git push -u test-output master;

  #Delete the branch we created before (branch05):
  #git push origin --delete branch01

#fi
