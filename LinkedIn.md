## Project Bedrock – AWS EKS Production Deployment

### Overview

Project Bedrock is a production-style DevOps project where I designed and deployed a scalable microservices application on Amazon EKS using Terraform, Kubernetes, and GitHub Actions.

The goal was to simulate a real-world cloud environment with automation, scalability, and security best practices.

### Architecture
- AWS VPC with public & private subnets
- Amazon EKS (managed Kubernetes cluster)
- Node groups for workload scaling
- NGINX Ingress Controller for traffic routing
- In-cluster microservices (frontend + backend services + dependencies)
- IAM-based access control with least privilege

### Tech Stack
AWS • Terraform • Kubernetes • Docker • GitHub Actions • Linux • NGINX

### What I Built
- Designed and deployed a production-style EKS cluster using Terraform
- Built custom VPC networking for secure cloud architecture
- Containerized and deployed multiple microservices on Kubernetes
- Configured internal service communication using ClusterIP services
- Exposed application via Ingress Controller for external access
- Implemented IAM + Kubernetes RBAC for secure access control

### CI/CD Automation
- GitHub Actions pipeline for Terraform validation and planning
- Automated infrastructure checks on every push and pull request
- Ensured reproducible and consistent deployments

### Security Highlights
- IAM roles with least-privilege access
- Kubernetes RBAC (read-only developer access)
- Secure handling of AWS credentials via GitHub Secrets

### Repository
GitHub: https://github.com/Jeffery-Aifuwa/Project-bedrock