```
gcloud container clusters create cassius --machine-type n2-standard-4 --num-nodes 1 --node-labels=cassandra.jenkins=controller --zone us-central1-c
gcloud container node-pools create agents --cluster cassius --machine-type c2-standard-8 --enable-autoscaling --min-nodes=0 --max-nodes=100 --node-labels=cassandra.jenkins=agent --zone us-central1-c
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
kubectl port-forward svc/cassius-jenkins 8080:8080
```

`machine type: n2-custom-10-40960`

Jenkins Credentials:
- User `admin`
- Password `admin`
