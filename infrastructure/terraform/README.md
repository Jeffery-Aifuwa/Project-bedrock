# Terraform Infrastructure for Project Bedrock

This folder contains the Terraform configuration to provision the AWS infrastructure for InnovateMart’s **Project Bedrock** (Retail Store Sample App).

## Folder Structure

| File          | Purpose |
|---------------|---------|
| `vpc.tf`      | Defines the Virtual Private Cloud (VPC), including public and private subnets, route tables, and internet gateways. |
| `eks.tf`      | Provisions the Amazon EKS cluster and node groups for running Kubernetes workloads. |
| `iam.tf`      | Creates the necessary IAM roles and policies for EKS, worker nodes, and service accounts. |
| `outputs.tf`  | Defines outputs such as VPC ID, Subnet IDs, and EKS cluster endpoint for use by other modules or documentation. |
| `providers.tf`| Configures the AWS provider and Terraform backend (if applicable). |
| `variables.tf`| Declares input variables for flexible configuration (e.g., region, instance types, cluster name). |

## Prerequisites

- AWS Account with programmatic access
- Terraform >= 1.7.0
- AWS CLI configured
- GitHub repository with workflow for CI/CD

## How to Deploy

1. **Initialize Terraform**

```
cd infrastructure/terraform
terraform init
```

2. **Validate Configuration**

```
terraform validate
```

3. **Format Configuration**

```
terraform fmt
```

4. **Create Execution Plan**

```
terraform plan -out=tfplan
```

5. **Apply Infrastructure**
```
terraform apply -auto-approve tfplan
```

6. **Verify Outputs**

```
terraform output
```

## Cleaning Up

To destroy the infrastructure and avoid unnecessary costs:

```
terraform destroy -auto-approve
```

## Notes

- State files (*.tfstate) and backups are excluded from the repository using .gitignore.

- GitHub Actions workflow (.github/workflows/terraform.yml) automates plan and apply when pushing to main.

- Update variables.tf to modify parameters like region, cluster name, or node sizes.

- Always review the execution plan before applying in a production environment.

## References

- [Terraform Documentation](https://www.terraform.io/docs)

- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)

- [AWS Provider for Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

