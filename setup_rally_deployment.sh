#!/bin/bash -x
#
# Example:
# ./deployment/docker_run_script.sh <tempest_source>:<version>
# ./deployment/docker_run_script.sh /home/rally/devops-qa-tools/tempest/:14.0.0

tempest_info=${1:-https://github.com/openstack/tempest.git:15.0.0}

get_parameters(){
    IFS=':' read -ra DATA <<< "$tempest_info"
    if [ "${DATA[0]}" == "http" -o "${DATA[0]}" == "https" ]; then
        tempest_source=$(echo $tempest_info|cut -d\: -f-2)
    else
        git clone https://github.com/openstack/tempest.git devops-qa-tools/tempest/
        tempest_source=$(echo $tempest_info|cut -d\: -f1)
    fi
    tempest_version=${DATA[-1]}
}

create_rally_deployment() {
    rally deployment create --filename docker_rally/deployment_configuration.json --name=tempest
}

create_verifier(){
    rally verify create-verifier --name tempest_tests --type tempest --source $tempest_source --version $tempest_version
}

combine_rally_scenarios(){
    pushd docker_rally/rally-scenarios/
    ./combine_files.py --filename all_scenarios.yaml
    popd
    echo
    echo 'For more information on rally-scenarios check rally-scenarios/README.md'
}

get_parameters
create_rally_deployment
create_verifier
combine_rally_scenarios