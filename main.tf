# terraform main configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "dev"
  region  = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
}