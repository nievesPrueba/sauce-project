#!/usr/bin/env bash

echo "Executing the execute-test.sh file"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then

  echo "Running mvn test command"
  mvn test;
  
  # Rename results folder
  echo "Rename results folder"
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;

  # Configurating git (user.mail and user.name)
  echo "Configurate git"
  git config --global user.email "you@example.com";
  git config --global user.name "travis-arq-test";

  # Create the new branch (branch01) and add the folder
  echo "Creating a new branch"
  echo "Initialice the repository"
  git init;
  echo "Add a remote repository"
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/nievesSopra/hello-world.git;
  echo "Creat checkout of the branch"
  git checkout -b branch01;
  echo "Adding test folder to the branch"
  git add -f prueba01;
  echo "Commit the changes"
  git commit -m "esto es una prueba";
  echo "Saving changes in the github respository"
  git push -u test-output branch01;

  echo "Uniendo la rama con el maestro"
  #Merge branch01 into master branch:
  git fetch;
  git checkout -f master;
  #git merge --allow-unrelated-histories branch01;
  #npm run git.merge.legacy;
  git merge branch01 -m "Merged branches";
  git push -u test-output master;

  #Delete the branch we created before (branch05):
  #git push origin --delete branch01

#fi
