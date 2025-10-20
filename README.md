# AWS 3-Tier Architecture with Terraform (Free Tier Friendly + Jenkins CI/CD)

This project sets up a **3-tier architecture on AWS** using Terraform fully optimized for the AWS Free Tier.
Instead of a NAT Gateway (which costs money), it uses a **NAT Instance**, and there is **no load balancer or auto-scaling**, keeping costs low.

Now with **Jenkins integration**, you can **automate deployment, updates, and destruction** of this infrastructure no manual Terraform commands required.

---

## Services Used

* **VPC** – Custom VPC with public & private subnets
* **EC2** – Frontend, Backend, and NAT Instance
* **RDS** – MySQL database in private subnet
* **Security Groups** – Controlled access to servers
* **Key Pair** – SSH access for debugging / management

---

## Prerequisites

Before running this project, make sure you have:

* **AWS CLI** installed and configured (`aws configure`)
* **Terraform** installed
* **Jenkins** installed with AWS credentials configured

Jenkins should have a **pipeline job** pointing to this repo with a `Jenkinsfile` to fully automate deployment.

---

## How to Run

You have **two options**: manual Terraform or automated Jenkins deployment.

---

### 1. Manual Terraform

1. Clone the repository:

   ```bash
   git clone https://github.com/AdityaBhairawkar/aws_3tier_terraform
   cd aws_3tier_terraform/terraform
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Deploy Infrastructure:

   ```bash
   terraform apply -auto-approve
   ```

4. Access Application:
   After deployment, Terraform outputs the **public IP of the frontend EC2**.
   Copy that IP into your browser to see the application.

5. Destroy Infrastructure (to avoid charges):

   ```bash
   terraform destroy -auto-approve
   ```

---

### 2. Jenkins CI/CD Pipeline

1. Create a Jenkins pipeline job pointing to this repo.
2. Make sure **AWS credentials** are added in Jenkins (ID: `aws-access-key` / `aws-secret-key`).
3. Configure **Boolean Parameter** `DESTROY` in Jenkins (default = false).
4. Run the pipeline:

   * If `DESTROY = false` → Jenkins automatically runs `terraform init → plan → apply → output`.
   * If `DESTROY = true` → Jenkins asks for confirmation, then destroys the infrastructure.

You can also trigger this pipeline automatically via a **GitHub webhook** whenever you push changes.

---

## Project Structure

```text
terraform/
├── backend_userdata.sh.tpl
├── frontend_script.sh.tpl
├── ec2.tf
├── nat_script.sh
├── outputs.tf
├── provider.tf
├── rds.tf
├── security.tf
├── variable.tf
└── vpc.tf
```

---

## Notes

* **Free-tier optimized**: no NAT Gateway, no Load Balancer.
* Always destroy infrastructure after testing to avoid AWS charges.
* You can customize instance types, database name, and other variables in `variable.tf`.
* Jenkins integration makes this fully automated — less manual work, safer, and reproducible.
