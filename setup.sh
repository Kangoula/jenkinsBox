#!/bin/bash

function main {
  # check if a container created by this script isn't already running
  dj=$(docker ps --all --quiet --filter "name=jenkins")

  if [ -z $dj ]
  then
    build
  else
    byebye
  fi
}

# Builds the new jenkins container
function build {
  echo ""
  echo "-----------------------------------"
  echo "- Building Dockerfile for jenkins -"
  echo "-----------------------------------"
  echo ""
  docker build -t gdenis/jenkins -f Dockerfiles/Dockerfile .
  docker run -d -p 8080:8080 --privileged --name jenkins gdenis/jenkins
}

# Stops and removes the running jenkins container
function byebye {
  echo "A container for jenkins already exists"
  read -p "Do you want to stop and remove it ? (y/n) " ans
  while [ -z $ans ] || ([ $ans != "y" ] && [ $ans != "n" ])
  do
    read -p "Do you want to stop and remove it ? (y/n)" ans
  done

  if [ $ans = "y" ]
  then
    echo ""
    echo "-----------------------------------"
    echo "-  Stopping and removing jenkins  -"
    echo "-----------------------------------"
    echo ""

    echo "--> Stopping"
    sj=$(docker stop jenkins)
    [ ! -z $sj ] && echo "done"

    echo "--> Removing"
    rj=$(docker rm jenkins)
    [ ! -z $rj ] && echo "done"
  fi

  build
}

main
