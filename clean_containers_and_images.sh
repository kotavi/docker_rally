#!/bin/bash -x

container_id=$(docker ps -a -q)
docker stop $container_id
docker rm $container_id
# docker rm $(docker stop $(docker ps -a -q))

image_id=$(docker images -q)
docker rmi $image_id