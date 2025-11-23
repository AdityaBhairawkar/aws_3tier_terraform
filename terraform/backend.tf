terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "aditya-terraform-state-3tier"   
    key            = "terraform/3tier-app.tfstate"
    region         = "us-east-1"
    use_lockfile = true
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
