# DNS verification

Create a busybox deployment:

```
kubectl run busybox --image=busybox --command -- sleep 3600
```

List the pod created by the busybox deployment:

```
kubectl get pods -l run=busybox
output

NAME                       READY     STATUS    RESTARTS   AGE
busybox-2125412808-mt2vb   1/1       Running   0          15s
```

Retrieve the full name of the busybox pod:

```
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")
```

Execute a DNS lookup for the kubernetes service inside the busybox pod:

```
kubectl exec -ti $POD_NAME -- nslookup kubernetes
output

Server:    10.32.0.10
Address 1: 10.32.0.10 kube-dns.kube-system.svc.cluster.local

Name:      kubernetes
Address 1: 10.32.0.1 kubernetes.default.svc.cluster.local
```