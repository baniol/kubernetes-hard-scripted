#!/bin/bash

# Provisioning Pod Network Routes
# Pods scheduled to a node receive an IP address from the node's Pod CIDR range. 
# At this point pods can not communicate with other pods running on different nodes due to missing network routes.

# In this lab you will create a route for each worker node that maps the node's Pod CIDR range to the node's internal IP address.

#There are other ways to implement the Kubernetes networking model.: https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-achieve-this


# The Routing Table
# In this section you will gather the information required to create routes in the kubernetes-the-hard-way VPC network.

# Print the internal IP address and Pod CIDR range for each worker instance:

# for instance in worker-0 worker-1 worker-2; do
#   gcloud compute instances describe ${instance} \
#     --format 'value[separator=" "](networkInterfaces[0].networkIP,metadata.items[0].value)'
# done

# Create network routes for each worker instance:

for i in 0 1 2; do
  gcloud compute routes create kubernetes-route-10-200-${i}-0-24 \
    --network ${PROJ_NAME} \
    --next-hop-address 10.240.0.2${i} \
    --destination-range 10.200.${i}.0/24
done

# List the routes in the ${PROJ_NAME} VPC network:

gcloud compute routes list --filter "network: ${PROJ_NAME}"