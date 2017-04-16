#!/bin/bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 /path/to/application" 1>&2
  exit 1
fi

cp docker-compose.dev.yml Dockerfile.dev .env.dev database.yml $1 &&
mv $1/docker-compose.dev.yml $1/docker-compose.yml &&
mv $1/Dockerfile.dev $1/Dockerfile
