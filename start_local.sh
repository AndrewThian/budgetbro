#!/bin/bash
clear

VOLUME_DIR=/usr/local/docker_mounts/budgetbro_dev
# provide another path if you do not with to use the default
if ! [ -z "$1" ]; then
    VOLUME_DIR=$1
fi

echo "mounting dataase to $VOLUME_DIR"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# get current directory and set schema.pgsql
echo "importing schema from: $DIR/database/schema.sql"

CONTAINER_ID=budgetbro_dev

docker run --rm -d \
--name $CONTAINER_ID \
-e POSTGRES_DB=$CONTAINER_ID \
-e POSTGRES_USER=$CONTAINER_ID \
-e POSTGRES_PASSWORD=docker \
-v $VOLUME_DIR:/var/lib/postgresql/data \
-v $DIR/database/schema.sql:/docker-entrypoint-initdb.d/schema.sql \
-p 5432:5432 \
postgres:9.6
    
if [ `docker inspect -f {{.State.Running}} $CONTAINER_ID` ]; then
    echo "Postgres started. access via root:root@0.0.0.0:5432/$CONTAINER_ID"
    echo "Stop the DB with:"
    echo "docker stop $CONTAINER_ID"
else
    echo "could not start container"
fi
