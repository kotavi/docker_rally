#!/bin/bash -x

stop_remove_containers(){
    container_id=$(docker ps -a -q)
    docker stop $container_id
    docker rm $container_id
    # docker rm $(docker stop $(docker ps -a -q))
}

remove_images(){
    image_id=$(docker images -q)
    docker rmi $image_id
}

stop_remove_containers
remove_images