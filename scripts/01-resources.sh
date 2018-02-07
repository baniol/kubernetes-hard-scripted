#!/bin/bash

gcloud compute networks create $PROJ_NAME --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network $PROJ_NAME \
  --range 10.240.0.0/24

gcloud compute firewall-rules create ${PROJ_NAME}-allow-internal \
  --allow tcp,udp,icmp \
  --network ${PROJ_NAME} \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create ${PROJ_NAME}-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network ${PROJ_NAME} \
  --source-ranges 0.0.0.0/0

gcloud compute firewall-rules list --filter="network:${PROJ_NAME}"

gcloud compute addresses create ${PROJ_NAME} \
  --region $(gcloud config get-value compute/region)

for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1604-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags ${PROJ_NAME},controller
done

for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1604-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags ${PROJ_NAME},worker
done

gcloud compute instances list