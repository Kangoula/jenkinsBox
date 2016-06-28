#!/bin/bash

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
