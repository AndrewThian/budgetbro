#!/bin/bash

docker run --rm -d \
    --name budgetbro_dev \
    -v /usr/local/docker_mounts/budgetbro_dev:/var/lib/postgresql/data \
    -e POSTGRES_DB=budgetbro_dev \
    -e POSTGRES_USER=budgetbro_dev \
    -e POSTGRES_PASSWORD=docker \
    -v /usr/local/docker_mounts/budgetbro_dev:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:9.6
    
