#!/usr/bin/env bash

yum install git
yum install docker

git clone https://github.com/AlexBalenko/mcp-rally-verify.git
cd mcp-rally-verify/
sed -i -- 's/keystonerc/openrc/g' *
./prepare_env.sh
