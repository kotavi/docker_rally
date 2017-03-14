#!/bin/bash -x

initialize_mos_variables(){
    source /home/rally/devops-qa-tools/openrc
}

setup_rally_deployment() {
    rally-manage db recreate
    rally deployment create --fromenv --name=tempest
    rally verify create-verifier --name tempest_tests --type tempest --source https://github.com/openstack/tempest.git
    rally verify list-verifiers
    rally verify show-verifier
    rally deployment show
}

combine_rally_scenarios(){
    pwd
    cd devops-qa-tools/rally-scenarios/
    sudo ./combine_files.py --filename all_scenarios.yaml
    echo 'To run Rally with all scenarios use the next command:
    rally task start all_scenarios.yaml --task-args-file task_arguments.yaml
    To create file with scenarios for specific service use the next command:
    ./combine_files.py --path <service_name>/ --filename <service_name>_scenarios.yaml
    Example:
    ./combine_files.py --path neutron/ --filename neutron_scenarios.yaml'
}

initialize_mos_variables
setup_rally_deployment
combine_rally_scenarios
