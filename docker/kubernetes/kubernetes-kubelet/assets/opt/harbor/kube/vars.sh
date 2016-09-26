#!/bin/bash
: ${AUTH_KUBE_KEYSTONE_PROJECT:="service"}
: ${AUTH_KUBE_KEYSTONE_PROJECT_DOMAIN:="default"}
: ${AUTH_KUBE_KEYSTONE_PROJECT_USER_ROLE:="admin"}
: ${AUTH_KUBE_KEYSTONE_DOMAIN:="default"}
: ${AUTH_KUBE_KEYSTONE_REGION:="RegionOne"}

: ${AUTH_FLEXVOLUME_KEYSTONE_NAMESPACE:=" kube-system"}
: ${AUTH_FLEXVOLUME_KEYSTONE_SECRET:="flexvolume-keystone"}

: ${AUTH_FLEXVOLUME_KEYSTONE_PROJECT:="service"}
: ${AUTH_FLEXVOLUME_KEYSTONE_PROJECT_DOMAIN:="default"}
: ${AUTH_FLEXVOLUME_KEYSTONE_PROJECT_USER_ROLE:="admin"}
: ${AUTH_FLEXVOLUME_KEYSTONE_DOMAIN:="default"}
: ${AUTH_FLEXVOLUME_KEYSTONE_REGION:="RegionOne"}


: ${FLEXVOLUME_IMAGE:="docker.io/port/openstack-cinder-mounter:latest"}
