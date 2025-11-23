# AWS 3-Tier Architecture with Terraform + Jenkins CI/CD (Production-Ready)

This project deploys a complete **3-tier architecture on AWS** using Terraform and automated CI/CD with Jenkins.  
It includes a **public frontend**, **private backend**, **private RDS**, multi-AZ networking, and a **remote backend** using S3.

The entire infrastructure can be **created or destroyed through Jenkins** with a single toggle (`DESTROY=true/false`).  
No manual Terraform commands required.

---

## Architecture Overview

This project provisions a real 3-tier stack:

### 🔹 **Network (VPC Layer)**
- 1× Custom VPC (10.0.0.0/16)
- 2× Public subnets (for frontend + NAT Gateways)
- 2× Private subnets (for backend + RDS)
- 2× NAT Gateways (one in each AZ)
- Internet Gateway
- Route tables (public + private per AZ)

### 🔹 **Compute Layer**
- Frontend EC2 instance (public subnet)
- Backend EC2 instance (private subnet)
- SSH restricted to **your IP only**

### 🔹 **Database Layer**
- RDS MySQL instance (private subnets only)
- Secure with DB subnet group + SG restrictions

### 🔹 **Security**
- Security Groups per tier (frontend, backend, DB)
- No public access to backend or database
- SSH restricted using a Terraform variable (`ssh_allowed_cidr`)

### 🔹 **Remote State Backend**
- Terraform state stored in **S3**
- State locking using **lockfile** (no DynamoDB required)
- Safe for Jenkins & team use

---

## Prerequisites

Before using this project, ensure you have:

- AWS account with permissions for VPC/EC2/RDS/S3
- **S3 bucket** for Terraform remote state (you must create this manually)
- Terraform installed (v1.3+)
- Jenkins installed with:
  - AWS credentials  
  - Pipeline job pointing to this repository

---

## Repository Structure

```

terraform/
├── backend.tf
├── backend_userdata.sh.tpl
├── frontend_script.sh.tpl
├── ec2.tf
├── outputs.tf
├── provider.tf
├── rds.tf
├── security.tf
├── variable.tf
└── vpc.tf

```

---

## How to Deploy via Jenkins (Recommended)

1. Create a Jenkins Pipeline job pointing to this repo.
2. Add AWS credentials with IDs:
   - `aws-access-key`
   - `aws-secret-key`
3. Run the job with parameter:

```

DESTROY = false

```

### Jenkins will automatically:
- `terraform init`
- `terraform plan`
- `terraform apply`
- Print frontend public IP for access

---

## How to Destroy Infrastructure (Through Jenkins)

Simply re-run the pipeline with:

```

DESTROY = true

```

Jenkins will ask for confirmation and then execute:

```

terraform destroy -auto-approve

````

Everything — VPC, EC2, NAT Gateways, RDS, subnets — will be deleted safely.

---

## Manual Terraform (Optional)

If you want to deploy manually:

```bash
git clone https://github.com/AdityaBhairawkar/aws_3tier_terraform
cd aws_3tier_terraform/terraform

terraform init
terraform plan
terraform apply -auto-approve
````

To destroy:

```bash
terraform destroy -auto-approve
```

> Note: You must have the remote backend S3 bucket created before running `terraform init`.

---
