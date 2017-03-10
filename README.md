## Prepare node for rally and tempest testing

#### Step 1.

Copy repository

``git clone https://github.com/kotavi/docker_rally``
``cd docker_rally``

#### Step 2.

Execute ``./install.sh`` to retrieve controller ip, install `git`, `docker` and copy `openrc` to the current directory

After this `openrc` file should be in the current directory.

#### Step 3.

Execute ``./docker_run_script.sh`` to pull rally docker image and start rally container.
Rally container starts with ``./fix_deployment_config.sh`` command.
This script:

 - sets up rally deployment
 - recreates deployment with correct config
 - installs tempest
 - creates all_scenarios.yaml with rally scenarios

#### Step 4.

Run Rally with all scenarios using  the next command:

``rally task start <name_of_file_with_scenarios> --task-args-file task_arguments.yaml``

To create file with scenarios for specific service use the next command:

``./combine_files.py --path <service_name>/ --filename <service_name>_scenario.yaml``

Example:

``./combine_files.py --path neutron/ --filename neutron_scenario.yaml``
