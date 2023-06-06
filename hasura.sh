#!/bin/bash

# This script fetches a docker-compose.yml, then deploys Hasura GraphQL Engine and Postgres database using Docker Compose.

# Download docker-compose.yml
if [ -f docker-compose.yml ]
then 
  echo -e "\n\033[1;32m==== docker-compose.yml present ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Curling docker-compose.yml ====\033[0m\n"
  sudo curl https://raw.githubusercontent.com/hasura/graphql-engine/stable/install-manifests/docker-compose/docker-compose.yaml -o docker-compose.yml
fi

# Start Hasura GraphQL Engine and Postgres database in Docker containers
if [ "$(curl -s -o /dev/null -w "%{http_code}" http://pi:8080/console)" -eq 200 ] 
then 
  echo -e "\n\033[1;32m==== Hasura GraphQL Engine and Postgres database started ====\033[0m\n"
else
  echo -e "\n\033[1;33m==== Starting Hasura GraphQL Engine and Postgres database ====\033[0m\n"
  sudo docker compose up -d
fi

