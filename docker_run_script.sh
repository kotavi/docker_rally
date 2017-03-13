#!/bin/bash -x

docker pull rallyforge/rally:latest

image_id=$(docker images | grep latest | awk '{print $3}'| head -1)
echo $image_id

docker_dir=/home/rally/files
docker run -d -ti -v /var/temp:$docker_dir --net host $image_id

container_id=$(docker ps -a | grep $image_id | awk '{print $1}'| head -1)
echo $container_id

docker exec -ti $container_id bash -c "$docker_dir/setup_rally_deployment.sh"
docker exec -ti $container_id bash
