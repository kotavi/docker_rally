#!/usr/bin/env bash

node_ip=$1
yum -y install git
yum -y install docker

service docker start

scp $node_ip:/root/openrc .
