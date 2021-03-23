variable "env" {
  default     = ""
  description = "environment"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "app-name" {
  default = "terraform-eks-demo"
}

variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = string
}