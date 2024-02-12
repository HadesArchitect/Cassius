```
gcloud container clusters create kotik --machine-type n2-custom-10-40960 --num-nodes 2 --zone us-central1-c
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
kubectl port-forward svc/cassius-jenkins 8080:8080
```

`machine type: n2-custom-10-40960`

Jenkins Credentials:
- User `admin`
- Password `admin`
