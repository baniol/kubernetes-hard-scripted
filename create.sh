#!/bin/bash

set -e

# If you are using the gcloud command-line tool for the first time init is the easiest way to do this:
#gcloud init

export REGION=us-west1
export ZONE=us-west1-c

#Otherwise set a default compute region:
gcloud config set compute/region ${REGION}

# Set a default compute zone:
gcloud config set compute/zone ${ZONE}

export PROJ_NAME=kubernetes-the-hard-way

cd scripts

./01-resources.sh
./02-certs.sh
./03-kubeconfig.sh
./04-bootstrap-etcd.sh
./05-control-plane.sh
./06-rbac.sh
./07-loadbalancer.sh
./08-worker-nodes.sh
./09-access.sh
./10-network-routes.sh
./11-dns.sh