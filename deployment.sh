#!/bin/bash

# Exit on error
set -e

# Run PostgreSQL and Nginx setup script
bash mypostgresql.sh

# Pull latest code from repository
git pull origin master

# Build and start Docker containers
docker-compose -f docker-compose.yml up -d --build

# Follow logs
docker logs -f abzhardware
