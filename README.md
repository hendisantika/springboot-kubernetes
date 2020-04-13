# springboot-kubernetes
## Create a docker image by using the below command

```
docker build -t springboot-k8s:1.0
```

## Create a deployment by using the below command
```shell script
kubectl run springboot-k8s --image=springboot-k8s:1.0 --port 8080 --image-pull-policy=Never

```
## Created a service by using the below command
```shell script
kubectl expose deployment springboot-k8s --type=NodePort
```

## You can scale the deployment by using the below command
```shell script
kubectl scale --replicas=3 deployment/springboot-k8s
```
## You can autoscale the deployment by using the below command
```shell script
kubectl autoscale deployment springboot-k8s --cpu-percent=50 --min=1 --max=10
```

## Create a docker image 2.0 version to update the deployment by using the below command
```shell script
docker build -t springboot-k8s:2.0
```
## You can update the deployment by using the below command
```shell script
kubectl set image deployment springboot-k8s springboot-k8s=springboot-k8s:2.0
```

## Command to see a list of Pods
```shell script
kubectl get pods
```
## Command to see a list of Deployments
```shell script
kubectl get deployments
```

## Command to see a list of Services
```shell script
kubectl get services
```
