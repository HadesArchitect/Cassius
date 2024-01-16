```
helm upgrade --install -f values.yaml cassius jenkins/jenkins --wait
kubectl port-forward svc/cassius-jenkins 8080:8080
```

Jenkins Credentials:
- User `admin`
- Password `admin`
