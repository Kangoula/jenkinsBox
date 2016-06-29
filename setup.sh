#!/bin/bash

function run {
  dr=registry
  dj=jenkins
  drd=registry/data
  djd=jenkins/data
  da=auth

  if [ ! -d $dr ]
  then
    mkdir $dr
    echo "Directory $dr created"
  fi
  
  if [ ! -d $dj ]
  then
    mkdir $dj
     echo "Directory $dj created"
  fi
  
  if [ ! -d $drd ]
  then
    mkdir $drd
    echo "Directory $drd created"
  fi
  
  if [ ! -d $djd ]
  then
    mkdir $djd
    echo "Directory $djd created"
  fi
  
  if [ ! -d $da ]
  then
    mkdir $da
    echo "Directory $da created"
  fi

  ./scripts/setupDockerRegistry.sh
  ./scripts/setupJenkins.sh

  echo ""
  echo "--------------------------------"
  echo "- Running Jenkins and Registry -"
  echo "--------------------------------"
  echo ""

  docker-compose up -d

  echo "done"
  echo ""
}

function main {
  dc=certs

  if [ -d "$dc" ]
  then
    if [ ! -f $dc/domain.crt ]
    then
      >&2 echo "ERROR: file certs/domain.crt is missing. Aborting"
    elif [ ! -f $dc/domain.key ]
    then
      >&2 echo "ERROR: file certs/domain.key is missing. Aborting"
    else
      run
    fi
  else
    >&2 echo "ERROR: the certificates directory is absent"
    echo "Please add a directory named 'certs' with files domain.crt and domain.key inside"
  fi
}

main
