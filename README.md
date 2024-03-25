## Installation

```
gcloud container clusters create cassius --machine-type n2-standard-4 --num-nodes 1 --node-labels=cassandra.jenkins=controller --zone us-central1-c --autoscaling-profile optimize-utilization
gcloud container node-pools create agents --cluster cassius --machine-type c2-standard-8 --enable-autoscaling --num-nodes=0 --min-nodes=0 --max-nodes=100 --node-labels=cassandra.jenkins=agent --zone us-central1-c
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
```

## Access

There are two ways to access your jenkins installation, port-forwarding (simplest, but available only to a local user) OR using load balancer.

### Local-only Access

```
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
```

### Public Access

To make Jenkins controller publicly available, uncomment three lines in `values.yaml` 

- controller.serviceType
- controller.ingress.enabled

AND CHANGE PASSWORD (controller.jcasc.securityrealm.local.users.password)

To get URL run `kubectl describe svc cassius-jenkins | grep 'LoadBalancer Ingress'` and use port 8080

To enable public access after deploying the helm chart, execute upgrade to deliver changes: `helm upgrade -f values.yaml cassius jenkins/jenkins --wait`. Notice that deployment of a load balancer can take up to few minutes.

Jenkins Credentials:
- User `admin`
- Password `admin`
