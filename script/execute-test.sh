#!/usr/bin/env bash

echo "Executing the execute-test.sh file"

REGEX_TAG="(.*)-TESTME"
#REGEX_TAG="(.*)-t(.*)"


if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  # Get Application repository Name
  REPO_NAME=$(echo ${TRAVIS_REPO_SLUG} | cut -f2 -d/)
  echo "REPO_NAME=${REPO_NAME}"
  
  # Save version
  VERSION=${REPO_NAME}-${BASH_REMATCH[1]}-Results;
  AUXBRANCH=${VERSION}-Branch01;
  echo "${VERSION}-Branch01"

  echo "Running mvn test command"
  mvn test -Denv.IPTRAVIS=http://$1 -Denv.SAUCELABS_USER=${SAUCELABS_USER} -Denv.SAUCELABS_ACCESS_KEY=${SAUCELABS_ACCESS_KEY};
  
  # Rename results folder
  echo "Rename results folder"
  cd /home/travis/build/${GITHUB_USER}/sauce-project/target; 
  mv surefire-reports ${VERSION};

  # Configurating git (user.mail and user.name)
  echo "Configurate git"
  git config --global user.email "you@example.com";
  git config --global user.name "${GITHUB_USER}";

  # Create the new branch (branch01) and add the folder
  echo "Creating a new branch"
  echo "Initialice the repository"
  git init;
  echo "Add a remote repository"
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/${GITHUB_USER}/hello-world.git;
  echo "Creat checkout of the branch"
  git checkout -b ${VERSION}-Branch01;
  echo "Adding test folder to the branch"
  git add -f ${VERSION};
  echo "Commit the changes"
  git commit -m "add results folder";
  echo "Saving changes in the github respository"
  git push -u test-output ${VERSION}-Branch01;

  echo "Merge between the bratch and master"
  #Merge branch01 into master branch:
  git fetch;
  git checkout -f master;
  #git merge --allow-unrelated-histories branch01;
  git merge ${VERSION}-Branch01 -m "Merged branches";
  git push -u test-output master;

  #Delete the branch we created before (branch01):
  git push test-output --delete ${VERSION}-Branch01

fi
