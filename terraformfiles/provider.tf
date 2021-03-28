provider "aws" {
  profile = var.env
  region  = var.aws_region
}

//module "ec2" {
//  source = "./modules/ec2"
//}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}