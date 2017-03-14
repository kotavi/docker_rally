## Prepare node for rally and tempest testing

### Description of scripts

- setup_network_fuel_node.sh - setup management network so that tests will have access from fuel node to the services
- install.sh - deploys and starts docker process, copies `openrc` file from one of the controllers to fuel node
- clean_containers_and_images.sh - removes all containers and images
- docker_run_script.sh - pulls rally docker image and runs it
- setup_rally_deployment.sh - sets up rally deployment, installs tempest, clones repo with rally scenarios

#### Setup network for Fuel node.

Execute ``./setup_network_fuel_node.sh``

```bash
Example of success
[root@ic4-fuel-scc docker_rally]# ./setup_network_fuel_node.sh
Management network information:
11 | management    | 301        | 10.31.0.0/24   \|             | 3
Enter ip address \(e.q. 10.109.6.233/24\):
10.31.0.253/24
Enter broadcast address:
10.31.0.255

The next COMMANDS will be executed, please CHECK them:

ip link add link eth1 name eth1.301 type vlan id 301
ip addr add 10.31.0.253/24 brd 10.31.0.255 dev eth1.301
ip link set dev eth1.301 up

Proceed \(Y/N\):
Y
ip link add link eth1 name eth1.301 type vlan id 301
ip addr add 10.31.0.253/24 brd 10.31.0.255 dev eth1.301
ip link set dev eth1.301 up
```

Example when ip address is already in use

```bash
./setup_network_fuel_node.sh
Management network information:
11 | management | 301 | 10.31.0.0/24 \| \| 3
Enter ip address \(e.q. 10.109.6.233/24\):
10.31.0.253/24
Enter broadcast address:
10.31.0.255
IP ADDRESS IS NOT AVAILABLE
Enter ip address \(e.q. 10.109.6.233/24\):
```

#### Install required packages and copy openrc file 

Execute ``./install.sh`` which runs the next:
 - retrieves controller ip
 - installs `docker`
 - copies `openrc` from controller to fuel node to the current directory

#### Pull rally docker image and start rally container

Execute ``./docker_run_script.sh``

This script:
 - pulls rally image
 - runs image and copies all from current directory to `/home/rally/devops-qa-tools` in container
 - sets up rally deployment
 - installs tempest
 - container starts with ``setup_rally_deployment.sh`` command.
 - creates all_scenarios.yaml with rally scenarios

#### Run Rally with scenarios

To create file with scenarios for specific service use the next command:

``./combine_files.py --path <service_name>/ --filename <service_name>_scenario.yaml``

To create file with scenarios from all services use the next command:

``./combine_files.py --filename <service_name>_scenario.yaml``

Run Rally using the next command:

``rally task start <name_of_file_with_scenarios> --task-args-file task_arguments.yaml``

#### Run Tempest smoke tests

``rally verify start --pattern set=smoke``