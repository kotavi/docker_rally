#!/usr/bin/env bash

. /home/rally/openrc
rally deployment create --fromenv --name test_rally


git clone https://github.com/kotavi/mos-initial-check-rally-scenarios.git
cd mos-initial-check-rally-scenarios/

