#!/bin/bash

# Deploying the DNS Cluster Add-on
# In this lab you will deploy the DNS add-on which provides DNS based service discovery 
# to applications running inside the Kubernetes cluster.
# https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/


kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml

# List the pods created by the kube-dns deployment:

kubectl get pods -l k8s-app=kube-dns -n kube-system