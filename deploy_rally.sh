#!/usr/bin/env bash

yum -y install git
yum -y install docker

git clone https://github.com/AlexBalenko/mcp-rally-verify.git
cd mcp-rally-verify/
sed -i -- 's/keystonerc/openrc/g' *
./prepare_env.sh
git clone https://github.com/kotavi/docker_rally.git
cd docker_rally/
./fix_deployment_config.sh
