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

variable "service-name" {
  default = "rest-service"
  type    = string
}

variable "aws_account_id" {
  default     = "${TF_VAR_AWS_ACCOUNT_ID}"
  type    = string
}

variable "repo_name" {
  default     = "${TF_VAR_REPO_NAME}"
  type    = string
}