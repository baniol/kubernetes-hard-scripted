#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
    gcloud compute scp control-plane.sh ${instance}:~/
    gcloud compute ssh ${instance} --zone ${ZONE} -- './control-plane.sh'
done