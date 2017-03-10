#!/bin/bash -x
#
# Prepare node for further Rally installation

node_ip=$1

install_packages() {
    if [ -f /etc/redhat-release ]; then
        istalator="yum"
    fi

    if [ -f /etc/lsb-release ]; then
        istalator="apt-get"
    fi

    $istalator -y install git
    $istalator -y install docker
}

start_processes() {
    service docker start
}

###########################################
# Copy openrc file from controller node
# to fuel node from where rally will be run
# Arguments:
#   Requires ip address of controller node
# Returns:
#   None
#######################################
copy_files() {
    scp $node_ip:/root/openrc .
    chmod +r openrc
}
install_packages
start_processes
copy_files
