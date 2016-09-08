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
echo "${OS_DISTRO}: Configuring database connection"
################################################################################
. /etc/os-container.env
. /opt/harbor/service-hosts.sh
. /opt/harbor/harbor-common.sh
. /opt/harbor/heat/vars.sh


################################################################################
check_required_vars HEAT_CONFIG_FILE \
                    OS_DOMAIN \
                    HEAT_MARIADB_SERVICE_HOST_SVC \
                    HEAT_MARIADB_SERVICE_PORT \
                    HEAT_DB_CA \
                    HEAT_DB_KEY \
                    HEAT_DB_CERT \
                    AUTH_HEAT_DB_USER \
                    AUTH_HEAT_DB_PASSWORD \
                    AUTH_HEAT_DB_NAME


################################################################################
crudini --set ${HEAT_CONFIG_FILE} database connection \
"mysql+pymysql://${AUTH_HEAT_DB_USER}:${AUTH_HEAT_DB_PASSWORD}@${HEAT_MARIADB_SERVICE_HOST_SVC}:${HEAT_MARIADB_SERVICE_PORT}/${AUTH_HEAT_DB_NAME}?charset=utf8&ssl_ca=${HEAT_DB_CA}&ssl_key=${HEAT_DB_KEY}&ssl_cert=${HEAT_DB_CERT}&ssl_verify_cert"
