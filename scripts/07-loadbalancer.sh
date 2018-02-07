#!/bin/bash

# The Kubernetes Frontend Load Balancer
# In this section you will provision an external load balancer to front the Kubernetes API Servers. 
# The kubernetes-the-hard-way static IP address will be attached to the resulting load balancer.

# The compute instances created in this tutorial will not have permission to complete this section. 
# Run the following commands from the same machine used to create the compute instances.

# Create the external load balancer network resources:

gcloud compute target-pools create kubernetes-target-pool

gcloud compute target-pools add-instances kubernetes-target-pool \
  --instances controller-0,controller-1,controller-2

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe ${PROJ_NAME} \
  --region $(gcloud config get-value compute/region) \
  --format 'value(name)')

gcloud compute forwarding-rules create kubernetes-forwarding-rule \
  --address ${KUBERNETES_PUBLIC_ADDRESS} \
  --ports 6443 \
  --region $(gcloud config get-value compute/region) \
  --target-pool kubernetes-target-pool

# ===========

# Verification
# Retrieve the kubernetes-the-hard-way static IP address:

cd certificates

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe ${PROJ_NAME} \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

# Make a HTTP request for the Kubernetes version info:

curl --cacert ca.pem https://${KUBERNETES_PUBLIC_ADDRESS}:6443/version
