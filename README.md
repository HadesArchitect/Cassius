# Installation

## Preparation

Following tools must be installed and available:

* kubectl
* gcloud
* helm

Add Helm repository for Jenkins

```
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

## Infrastructure

```
# cluster and controller node
gcloud container clusters create cassius --machine-type e2-standard-8 --disk-type=pd-ssd --num-nodes 1 --node-labels=cassandra.jenkins=controller --autoscaling-profile optimize-utilization --zone us-central1-c

# small resource nodes
gcloud container node-pools create agents-small --cluster cassius --machine-type n2-highcpu-4 --disk-type=pd-ssd --enable-autoscaling --spot --num-nodes=0 --min-nodes=0 --max-nodes=50 --node-labels=cassandra.jenkins=agent,cassandra.size=small --zone us-central1-c

# medium resource nodes
gcloud container node-pools create agents-medium --cluster cassius --machine-type n2-highcpu-8 --disk-type=pd-ssd --enable-autoscaling --spot --num-nodes=0 --min-nodes=0 --max-nodes=140 --node-labels=cassandra.jenkins=agent,cassandra.size=medium --zone us-central1-c

# large resource nodes
gcloud container node-pools create agents-large --cluster cassius --machine-type n2-highcpu-16 --disk-type=pd-ssd --enable-autoscaling --spot --num-nodes=0 --min-nodes=0 --max-nodes=140 --node-labels=cassandra.jenkins=agent,cassandra.size=large --zone us-central1-c

# auth (and make default context)
gcloud container clusters get-credentials cassius --zone us-central1-c

## Deployment

# deploy jenkins with helm
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait --timeout 10m

# get the server's address (may need to wait few minutes for answer to appear)
kubectl describe svc cassius-jenkins | grep 'LoadBalancer Ingress'

# get the jenkins' password
kubectl exec -it svc/cassius-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

# open http://<server_address>:8080
```

### Local-only Access

If you want only local private access to Jenkins, do the following.

Comment these lines before running `heml upgrade …`
```
  serviceType: LoadBalancer
  ingress:
    enabled: "true"
```
Run the heml upgrade and get the password as usual
```
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait

# get the jenkins' password
kubectl exec -it svc/cassius-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

# port-forward 8080 to the private jenkins
kubectl port-forward svc/cassius-jenkins 8080:8080

# open http://localhost:8080
```

