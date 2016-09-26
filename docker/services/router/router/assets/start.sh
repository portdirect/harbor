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
echo "${OS_DISTRO}: Starting Router Container"
################################################################################
touch /etc/os-container.env
source /etc/os-container.env
: ${CONTAINER_IFNAME:="eth1"}


################################################################################
check_required_vars CONTAINER_IFNAME


echo "${OS_DISTRO}: Waiting for ${CONTAINER_IFNAME}"
################################################################################
while true; do
# This first method works even without `ip` or `ifconfig` installed,
# but doesn't work on older kernels (e.g. CentOS 6.X). See #128.
grep -q '^1$' "/sys/class/net/$CONTAINER_IFNAME/carrier" && break
# This method hopefully works on those older kernels.
ip link ls dev "$CONTAINER_IFNAME" && break
sleep 1
done > /dev/null 2>&1


echo "${OS_DISTRO}: Setting Up iptables"
################################################################################
iptables -A FORWARD -i ${CONTAINER_IFNAME} -o eth0 -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE


echo "${OS_DISTRO}: Going to sleep"
################################################################################
exec tail -f /dev/null
