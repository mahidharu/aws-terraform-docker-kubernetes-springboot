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
  profile = "${var.env}"
  region  = "${var.region}"
}

module "ec2" {
  source = "./modules/ec2"
}