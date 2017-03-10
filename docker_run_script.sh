#!/bin/bash -x

docker pull rallyforge/rally:latest

image_id=$(docker images | grep latest | awk '{print $3}'| head -1)
echo $image_id

#docker run -d -ti --name $image_id --net host $image_id

docker run -d -ti /var/temp:/home/rally --net host $image_id

container_id=$(docker ps -a | grep $image_id | awk '{print $1}'| head -1)
echo $container_id

docker exec -ti $container_id bash -c "./fix_deployment_config.sh"
docker exec -ti $container_id bash
