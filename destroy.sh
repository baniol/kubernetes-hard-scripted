#!/bin/bash

PROJ_NAME=kubernetes-the-hard-way

gcloud -q compute instances delete \
  controller-0 controller-1 controller-2 \
  worker-0 worker-1 worker-2

gcloud -q compute forwarding-rules delete kubernetes-forwarding-rule \
  --region $(gcloud config get-value compute/region)

gcloud -q compute target-pools delete kubernetes-target-pool

gcloud -q compute addresses delete ${PROJ_NAME}

gcloud -q compute firewall-rules delete \
  ${PROJ_NAME}-allow-internal \
  ${PROJ_NAME}-allow-external

gcloud -q compute routes delete \
  kubernetes-route-10-200-0-0-24 \
  kubernetes-route-10-200-1-0-24 \
  kubernetes-route-10-200-2-0-24

gcloud -q compute networks subnets delete kubernetes

gcloud -q compute networks delete ${PROJ_NAME}

rm -fr scripts/certificates