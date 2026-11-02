# springboot-kubernetes

[![Spring Boot K8s application workflow](https://github.com/hendisantika/springboot-kubernetes/actions/workflows/app-workflow.yml/badge.svg)](https://github.com/hendisantika/springboot-kubernetes/actions/workflows/app-workflow.yml)
![Java](https://img.shields.io/badge/Java-25-orange?logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.1.x-6DB33F?logo=springboot)
![Kubernetes](https://img.shields.io/badge/Kubernetes-ready-326CE5?logo=kubernetes)

A simple Spring Boot REST application that shows how to containerize an app and deploy it to Kubernetes.

## Tech Stack

| Component      | Version                                  |
|----------------|------------------------------------------|
| Java           | 25 (Amazon Corretto)                     |
| Spring Boot    | 4.1.x (Web MVC, Actuator)                |
| Build tool     | Maven 3.9.11 (wrapper included: `./mvnw`) |
| Testing        | JUnit 5, Testcontainers 2.x              |
| Container      | Docker (`amazoncorretto:25-alpine-jdk`, multi-stage, non-root) |
| Orchestration  | Kubernetes                               |
| CI/CD          | GitHub Actions + Dependabot              |

## Endpoints

| Method | Path                | Description                             |
|--------|---------------------|-----------------------------------------|
| GET    | `/`                 | Returns a greeting with current time    |
| GET    | `/actuator/health`  | Health check (useful for K8s probes)    |

## Prerequisites

- JDK 25
- Docker
- A Kubernetes cluster (Minikube, Kind, Docker Desktop, etc.) and `kubectl`

## Build & Run Locally

```shell script
./mvnw clean verify          # build and run tests
./mvnw spring-boot:run       # start the app on http://localhost:8080
```

## Docker

Create a docker image by using the below command:

```shell script
docker build -t springboot-k8s:1.0 .
docker run --rm -p 8080:8080 springboot-k8s:1.0
```

Alternatively, build an OCI image with Cloud Native Buildpacks:

```shell script
./mvnw spring-boot:build-image
```

## Kubernetes

### Create a deployment
```shell script
kubectl create deployment springboot-k8s --image=springboot-k8s:1.0 --port=8080
```

### Create a service
```shell script
kubectl expose deployment springboot-k8s --type=NodePort --port=8080
```

### Scale the deployment
```shell script
kubectl scale --replicas=3 deployment/springboot-k8s
```

### Autoscale the deployment
```shell script
kubectl autoscale deployment springboot-k8s --cpu-percent=50 --min=1 --max=10
```

### Roll out a new version
```shell script
docker build -t springboot-k8s:2.0 .
kubectl set image deployment springboot-k8s springboot-k8s=springboot-k8s:2.0
```

### Inspect resources
```shell script
kubectl get pods
kubectl get deployments
kubectl get services
kubectl describe deployments
kubectl describe replicasets
```

### Deploy using the manifest files
```shell script
kubectl apply -f deployment.yaml
kubectl apply -f src/main/resources/deployment.yml
kubectl apply -f src/main/resources/service.yml
```

## CI/CD

- **GitHub Actions** (`.github/workflows/app-workflow.yml`): builds and tests the project with JDK 25 on every push / PR
  to `master`, then builds and pushes the Docker image `hendisantika/springboot-kubernetes-sample:<run_number>` to
  Docker Hub (on `master` only). Requires the `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
- **Dependabot** (`.github/dependabot.yml`): keeps Maven dependencies, GitHub Actions and Docker base images up to
  date with grouped PRs, labels and conventional commit messages.

## Author

**Hendi Santika**

- Email: hendisantika@gmail.com
- Telegram: [@hendisantika34](https://t.me/hendisantika34)
- Link: [s.id/hendisantika](https://s.id/hendisantika)
