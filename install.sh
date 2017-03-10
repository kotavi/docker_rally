#!/bin/bash -x
#
# Prepare node for further Rally installation

get_controller_ip(){
    node_ip=$(fuel nodes | grep controller | awk '{print $9}' | head -1)
}

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
    if [ -d /var/temp ]; then
        echo 'path /var/temp exists'
    elif [ ! -d /var/temp ]; then
        mkdir /var/temp
    fi
    scp $node_ip:/root/openrc /var/temp/
    chmod +r /var/temp/openrc
    grep -v "export OS_ENDPOINT_TYPE='internalURL'" /var/temp/openrc > temp && mv temp /var/temp/openrc

    cp fix_deployment_config.sh /var/temp/

    if [ -f /var/temp/openrc -a -f /var/temp/fix_deployment_config.sh ]; then
        echo 'files were copied successfully'
    fi
}
get_controller_ip
install_packages
start_processes
copy_files
