#!/bin/bash

echo "Stopper alle kjørende containere..."
docker stop $(docker ps -aq) 2>/dev/null

echo "Sletter alle containere..."
docker rm $(docker ps -aq) -f 2>/dev/null

echo "Sletter alle Docker images..."
docker rmi $(docker images -q) -f 2>/dev/null

echo "Sletter alle Docker volumer..."
docker volume rm $(docker volume ls -q) -f 2>/dev/null

echo "Sletter alle Docker-nettverk (unntatt standard)..."
docker network prune -f

echo "Rydder opp all ubrukt Docker-data..."
docker system prune -a --volumes -f

echo "Alle Docker-containere, images, volumer og nettverk er slettet!"
