#!/usr/bin/env bash

. /home/rally/openrc

rally deployment config > depl.json

grep -v "\"endpoint_type\": \"internal\"," depl.json > temp && mv temp depl.json

rally deployment recreate --file depl.json
rally deployment show
rally deployment recreate --file depl.json
rally deployment show

git clone https://github.com/kotavi/mos-initial-check-rally-scenarios.git
cd mos-initial-check-rally-scenarios/
./combine_files.py --filename all_scenarios.yaml
rally task start all_scenarios.yaml --task-args-file task_arguments.yaml

