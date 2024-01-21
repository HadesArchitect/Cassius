```
gcloud container clusters create kotik --machine-type n2-standard-8 --num-nodes 2 --zone us-central1-c
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
kubectl port-forward svc/cassius-jenkins 8080:8080
```

Jenkins Credentials:
- User `admin`
- Password `admin`

# triggers {
#   hudsonStartupTrigger {
#     nodeParameterName("agent-dind")
#     label("agent-dind")
#     quietPeriod("0")
#     runOnChoice("False")
#   }
# }