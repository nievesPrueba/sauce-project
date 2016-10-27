#!/usr/bin/env bash

echo "Ejecutando execute-test.sh"

REGEX_TAG="(.*)-TESTME"

#if [[ "${TRAVIS_TAG}" =~ ${REGEX_TAG} ]]; then
  #echo "Instalando git"
  #sudo apt-get install git;
  #echo "Versión de git:"
  #git --version;
  
  echo "Generando tests..."
  mvn test;
  
  echo "Renombrando pruebas"
  cd /home/travis/build/nievesSopra/sauce-project/target; 
  mv surefire-reports prueba01;
  #curl https://api.github.com/?access_token=${TRAVIS_TOKEN};

  echo "Configuración de git"
  git config --global user.email "you@example.com";
  git config --global user.name "travis-arq-test";

  echo "Creando nueva rama"
  # Create the new branch (branch01) and add the folder
  echo "Iniciando repositorio"
  git init;
  echo "Añadiendo remotos"
  git remote add test-output https://${TRAVIS_TOKEN}@github.com/nievesSopra/hello-world.git;
  echo "Creando checkout de la rama"
  git checkout -b branch01;
  echo "Añadiendo carpeta de pruebas a la rama"
  git add -f prueba01;
  echo "Comiteando cambios"
  git commit -m "esto es una prueba";
  echo "Guardando cambios en repositorio de github
  git push -u test-output branch01;

  echo "Uniendo la rama con el maestro"
  #Merge branch01 into master branch:
  git fetch;
  git checkout -f master;
  #git merge --allow-unrelated-histories branch01;
  git merge branch01;
  git push -u test-output master;

  #Delete the branch we created before (branch05):
  #git push origin --delete branch01

#fi
