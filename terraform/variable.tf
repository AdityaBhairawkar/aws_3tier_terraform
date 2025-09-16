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
  description = "ami id"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
  description = "type of instance"
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

variable "db_password" {
  type    = string
  default = "password"
}

variable "rds_username" {
  type    = string
  default = "root"
}

variable "rds_db_name" {
  type    = string
  default = "todo_app"
}