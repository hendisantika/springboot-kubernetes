# springboot-kubernetes
## Create a docker image by using the below command

```
docker build -t springboot-k8s:1.0
```

# Create a deployment by using the below command
```shell script
kubectl run springboot-k8s --image=springboot-k8s:1.0 --port 8080 --image-pull-policy=Never

```

