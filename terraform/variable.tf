variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances."
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "az_names" {
  description = "A list of availability zones to use for the subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "project_name" {
  description = "The name of the project, used for resource tagging."
  type        = string
  default     = "tier3-app"
}

# SH – set this to YOUR PUBLIC IP with /32
variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH into frontend EC2."
  type        = string
  default     = "0.0.0.0/0"
}

#RDS credentials (simple variable-based approach)
variable "db_password" {
  description = "Password for the RDS database."
  type        = string
  default     = "password"
}

variable "rds_username" {
  description = "Username for the RDS database."
  type        = string
  default     = "root"
}

variable "rds_db_name" {
  description = "Database name for the RDS instance."
  type        = string
  default     = "todo_app"
}

# Optional: make RDS slightly more configurable
variable "rds_instance_class" {
  description = "Instance class for RDS."
  type        = string
  default     = "db.t3.micro"
}

variable "rds_allocated_storage" {
  description = "Allocated storage (GB) for RDS."
  type        = number
  default     = 20
}
