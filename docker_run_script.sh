#!/bin/bash -x
#
# To run script you can specify optional parameters:
# image_name and image_version
# ./docker_run_script.sh <image_name>:<image_version> <tempest_source>:<tempest_version>
# ./docker_run_script.sh  rallyforge/rally:latest /home/rally/devops-qa-tools/tempest/:14.0.0
# ./docker_run_script.sh  rallyforge/rally:latest https://github.com/openstack/tempest.git:14.0.0

fuel_dir=$(pwd)
docker_dir=/home/rally/docker_rally

image_info=${1:-rallyforge/rally:0.8.1}
image_name=$(echo $image_info|cut -d\: -f1)
image_version=$(echo $image_info|cut -d\: -f2)

tempest_info=${2:-https://github.com/openstack/tempest.git:15.0.0}

docker pull $image_name:$image_version

image_id=$(docker images $image_name:$image_version -q)

container_id=$(docker run -d -ti -v $fuel_dir:$docker_dir --net host --pid host $image_id)

docker exec -ti $container_id bash -c "sudo chown rally:rally -R $docker_dir/"
docker exec -ti $container_id bash -c "$docker_dir/setup_rally_deployment.sh $tempest_info"
docker exec -ti $container_id bash
