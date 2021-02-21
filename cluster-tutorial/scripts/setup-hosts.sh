#!/usr/bin/env bash

set -e

IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sudo sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# # remove ubuntu2004 entry
sudo sed -e '/^.*ubuntu2004.*/d' -i /etc/hosts

# Update /etc/hosts about other hosts
sudo cat >> /etc/hosts <<EOF
192.168.5.40  admin
192.168.5.30  lb

192.168.5.11  controller-1
192.168.5.12  controller-2
192.168.5.13  controller-3

192.168.5.21  worker-1
192.168.5.22  worker-2
192.168.5.23  worker-3
EOF
