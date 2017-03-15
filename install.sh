#!/bin/bash -x
#
# Prepare node for further Rally installation
# 1. Install needed packages
# 2. Copy openrc from controller to fuel node

controller_ip=$1

# move to precondition that docker has to be pre installed
install_packages() {
    if [ -f /etc/redhat-release ]; then
        istalator="yum"
    fi

    if [ -f /etc/lsb-release ]; then
        istalator="apt-get"
    fi

    $istalator -y install docker
}

start_processes() {
    service docker start
}

get_controller_ip(){
#    if [ $controller_ip -qe "" ]; then
#      node_ip=$(fuel nodes | grep controller | awk '{print $9}' | head -1)
#    else
#        node_ip=$controller_ip
#    fi
    node_ip=$(fuel nodes | grep controller | awk '{print $9}' | head -1)
}

copy_files() {
# Copy openrc file from controller node
#    fuel_nodes=$(fuel nodes)
#    if [ $fuel_nodes==*"command not found"* ]; then
#        cp /root/openrc .
#    else
#        scp $node_ip:/root/openrc .
#    fi
    sed "/export OS_ENDPOINT_TYPE='internalURL'/d" openrc > temp && mv temp openrc
}

install_packages
start_processes
get_controller_ip
copy_files
