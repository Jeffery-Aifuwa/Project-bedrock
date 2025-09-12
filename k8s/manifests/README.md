# Kubernetes Manifests for Project Bedrock

This folder contains the Kubernetes configuration files required to deploy the **Retail Store Sample App** and its supporting services.

## Folder Structure

| Folder / File        | Purpose |
|-----------------------|---------|
| `db/secrets.yaml`     | Contains Kubernetes Secret manifest for storing sensitive data such as database credentials. |
| `deployments/`        | Contains Deployment manifests for microservices and supporting components (`api`, `carts`, `catalog`, `orders`, `ui`, and `db`). |
| `services/db-services.yaml` | Contains Service manifest for exposing database deployments internally to other services. |
| `ingress/retail-store-ingress.yaml` | Defines Ingress rules to expose application services externally via the NGINX Ingress Controller. |

## Prerequisites

- Running EKS cluster with nodes ready
- NGINX Ingress Controller installed in the cluster
- Terraform infrastructure deployed (VPC, EKS, IAM roles)
- `kubectl` configured with cluster access

## Deployment Order

Apply the manifests in the following order:

1. **Secrets**
```
kubectl apply -f k8s/manifests/db/secrets.yaml
```

2. **Deployments**
```
kubectl apply -f k8s/manifests/deployments/
```

3. **Services**
```
kubectl apply -f k8s/manifests/services/
```

4. **Ingress**
```
kubectl apply -f k8s/manifests/ingress/
```

5. **Verify Deployment**
```
kubectl get pods -A
kubectl get svc -A
kubectl get ingress -A
```

## Notes

- Secrets should not be stored in plain text in production. Use tools like Sealed Secrets, HashiCorp Vault, or AWS Secrets Manager.

- All services are deployed into the default namespace unless specified otherwise.

- Ensure your Ingress Controller (NGINX or AWS ALB Ingress Controller) is already running before applying the Ingress manifest.

## References

- [Kubernetes Official Documentation](https://kubernetes.io/docs/)

- [AWS EKS User Guide](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

- [Retail Store Sample App Repository](https://github.com/aws-containers/retail-store-sample-app)