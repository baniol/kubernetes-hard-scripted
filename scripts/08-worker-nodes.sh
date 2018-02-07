#!/bin/bash

# Bootstrapping the Kubernetes Worker Nodes

# In this lab you will bootstrap three Kubernetes worker nodes. 
# The following components will be installed on each node: 
# runc : https://github.com/opencontainers/runc
# container networking plugins : https://github.com/containernetworking/cni
# cri-containerd : https://github.com/containerd/cri-containerd
# kubelet : https://kubernetes.io/docs/admin/kubelet
# kube-proxy : https://kubernetes.io/docs/concepts/cluster-administration/proxies

for instance in worker-0 worker-1 worker-2; do
    gcloud compute scp worker-nodes.sh ${instance}:~/
    gcloud compute ssh ${instance} --zone ${ZONE} -- './worker-nodes.sh'
done

# Verification
# Login to one of the controller nodes:

# gcloud compute ssh controller-0
# List the registered Kubernetes nodes:

# kubectl get nodes