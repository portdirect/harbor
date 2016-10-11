#!/bin/bash

# Copyright 2016 Port Direct
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
echo "${OS_DISTRO}: Configuring zone-manager"
################################################################################
. /etc/os-container.env
. /opt/harbor/service-hosts.sh
. /opt/harbor/harbor-common.sh
. /opt/harbor/designate/vars.sh
PROC_CORES=$(grep -c ^processor /proc/cpuinfo)
: ${API_WORKERS:="$(( ( $PROC_CORES + 1 ) / 2))"}


################################################################################
check_required_vars DESIGNATE_CONFIG_FILE \
                    OS_DOMAIN \
                    MY_IP \
                    API_WORKERS

################################################################################
crudini --set ${DESIGNATE_CONFIG_FILE} service:producer workers "${API_WORKERS}"
crudini --set ${DESIGNATE_CONFIG_FILE} service:producer threads "1000"
# List of Zone Manager tasks to enable, a value of None will enable all tasks.
crudini --set ${DESIGNATE_CONFIG_FILE} service:producer enabled_tasks "None"
crudini --set ${DESIGNATE_CONFIG_FILE} service:producer export_synchronous "True"