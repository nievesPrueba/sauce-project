#!/usr/bin/env sh

if [[ "${TRAVIS_TAG}" =~ (.*)-TESTME ]]; then
  mvn test; 
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01; 
  git remote add test-output ssh://nievesSopra@github.com/hello-world.git; 
  git push test-output prueba01; 
fi
