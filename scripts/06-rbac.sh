#!/bin/bash

# RBAC for Kubelet Authorization

# In this section you will configure RBAC permissions to allow the Kubernetes API Server 
# to access the Kubelet API on each worker node. 
# Access to the Kubelet API is required for retrieving metrics, logs, and executing commands in pods.

# This tutorial sets the Kubelet --authorization-mode flag to Webhook. 
# Webhook mode uses the SubjectAccessReview API to determine authorization.

gcloud compute scp rbac.sh controller-0:~/
gcloud compute ssh controller-0 --zone ${ZONE} -- './rbac.sh'

