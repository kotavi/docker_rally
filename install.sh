#!/bin/bash -x
#
# Prepare node for further Rally installation
# 1. Install needed packages
# 2. Copy openrc from controller to fuel node

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
    node_ip=$(fuel nodes | grep controller | awk '{print $9}' | head -1)
}

copy_files() {
# Copy openrc file from controller node
    scp $node_ip:/root/openrc .
    grep -v "export OS_ENDPOINT_TYPE='internalURL'" openrc > temp && mv temp openrc
}

install_packages
start_processes
get_controller_ip
copy_files
