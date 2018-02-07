#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
    gcloud compute scp etcd.sh ${instance}:~/
    gcloud compute ssh ${instance} --zone ${ZONE} -- './etcd.sh'
done


# Verification inside instances
# ETCDCTL_API=3 etcdctl member list