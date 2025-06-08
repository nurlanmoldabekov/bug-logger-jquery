#!/bin/bash

echo "Running Maven clean package..."
./mvnw clean package

echo "Stopping containers and removing images..."
docker compose down --rmi all

echo "Starting containers with a rebuild..."
docker compose up --build -d

./mvnw spring-boot:run -Dspring-boot.run.profiles=dev