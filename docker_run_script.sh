#!/bin/bash -x

fuel_dir=$(pwd)
docker_dir=/home/rally/devops-qa-tools

docker pull rallyforge/rally:latest

image_id=$(docker images | grep latest | awk '{print $3}'| head -1)

docker run -d -ti --net host $image_id

container_id=$(docker ps -a | grep $image_id | awk '{print $1}'| head -1)

docker cp $fuel_dir/ $container_id:$docker_dir

docker exec -ti $container_id bash -c "sudo chown rally:rally -R $docker_dir/"
docker exec -ti $container_id bash -c "$docker_dir/deployment/setup_rally_deployment.sh"
docker exec -ti $container_id bash
