#!/bin/bash

function main {
  # check if a container created by this script isn't already running
  dj=$(docker ps --all --quiet --filter "name=registry")

  if [ -z $dj ]
  then
    build
  else
    byebye
  fi
}

function build {
  echo ""
  echo "---------------------------"
  echo "- Building docker registry -"
  echo "---------------------------"
  echo ""
  echo "--> Creating password"
  mkdir ./auth
  docker run --name createPasswd -d --entrypoint htpasswd registry:2 -Bbn admin admin > auth/htpasswd
  docker stop createPasswd
  echo "done"
  echo "--> Building"
  docker-compose build registry
  # docker build -t gdenis/registry -f Dockerfiles/DockerfileRegistry .
  # docker run -d -p 5000:5000 --restart=always --name registry gdenis/registry
  # docker run -d -p 5000:5000 --name registry registry:latest
  echo "done"
  echo ""
}

function byebye {
  echo ""
  echo "----------------------------------"
  echo "- Stopping and removing registry -"
  echo "----------------------------------"
  echo ""
  echo "A container for registry already exists"
  read -p "Do you want to stop and remove it ? (y/n) " ans
  while [ -z $ans ] || ([ $ans != "y" ] && [ $ans != "n" ])
  do
    read -p "Do you want to stop and remove it ? (y/n)" ans
  done

  if [ $ans = "y" ]
  then
    echo "--> Stopping"
    sj=$(docker stop registry)
    [ ! -z $sj ] && echo "done"

    echo "--> Removing"
    rj=$(docker rm registry)
    [ ! -z $rj ] && echo "done"
  fi

  build
}

main