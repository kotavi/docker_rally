#!/usr/bin/env bash

docker build . -t testing_with_rally

image_id=$(docker images | grep latest| awk '{print $3}'| head -1)
echo $image_id

image_name=$(docker images| grep latest| awk '{print $1}'| head -1)
echo $image_name

docker run -d -ti --name $image_name --net host $image_id

container_id=$(docker ps -a | grep $image_id | awk '{print $1}'| head -1)
echo $container_id

docker exec -ti $container_id bash -c "./prepare.sh"
