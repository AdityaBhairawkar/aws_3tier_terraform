# AWS 3-Tier Architecture with Terraform (Free Tier Friendly)

This project sets up a simple 3-tier architecture on AWS using **Terraform** — while staying inside the AWS Free Tier.  
Instead of using a NAT Gateway (which costs money), this project uses a **NAT Instance**, and there is **no load balancer or auto-scaling** to keep costs low.

---

## Services Used
- **VPC** – Custom VPC with public & private subnets  
- **EC2** – Frontend, Backend, and NAT Instance  
- **RDS** – MySQL database in private subnet  
- **Security Groups** – To allow controlled access  
- **Key Pair** – For SSH access  

---

## ⚙️ Prerequisites
Before running this project, install & configure:
- AWS CLI and run `aws configure`
- Terraform

---

##  How to Run

1. **Clone this repository**  

   git clone https://github.com/AdityaBhairawkar/aws_3tier_terraform
   cd aws_3tier_terraform/terraform


2. **Initialize Terraform**

   terraform init
   

3. **Deploy Infrastructure**

   terraform apply -auto-approve
   

4. **Access Application**

   * After deployment, Terraform will output the **public IP of the frontend EC2 instance**.
   * Copy that IP and open it in a browser to view the application.


5. **Destroy Infrastructure (to avoid charges)**

   terraform destroy -auto-approve

---

## 🗂️ Project Structure

```
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

* This project is **free-tier optimized** (no NAT Gateway, no Load Balancer).
* Always run `terraform destroy -auto-approve` after testing to avoid extra AWS costs.
* You can customize instance types, DB name, and other variables in `variable.tf`.
