#!/bin/bash -x

initialize_mos_variables(){
    source /home/rally/openrc
}

setup_rally_deployment() {
    rally-manage db recreate
    rally deployment create --fromenv --name=tempest

    rally verify create-verifier --name tempest_tests --type tempest --source https://github.com/openstack/tempest.git
    rally verify list-verifiers
    rally verify show-verifier

    rally deployment config > depl.json

    grep -v "\"endpoint_type\": \"internal\"," depl.json > temp && mv temp depl.json

    rally deployment recreate --file depl.json
    rally deployment show
    rally deployment recreate --file depl.json
    rally deployment show
}

clone_rally_scenarios(){
    git clone https://github.com/kotavi/mos-initial-check-rally-scenarios.git
    cd mos-initial-check-rally-scenarios/
    ./combine_files.py --filename all_scenarios.yaml
    echo 'To run Rally with all scenarios use the next command:'
    echo 'rally task start all_scenarios.yaml --task-args-file task_arguments.yaml'
    echo
    echo 'To create file with scenarios for specific service use the next command:'
    echo './combine_files.py --path <service_name>/ --filename <service_name>_scenario.yaml'
    echo 'Example:'
    echo './combine_files.py --path neutron/ --filename neutron_scenario.yaml'
}

initialize_mos_variables
setup_rally_deployment
clone_rally_scenarios
