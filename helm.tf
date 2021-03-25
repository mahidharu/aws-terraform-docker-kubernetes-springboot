provider "helm" {
  kubernetes {
    host = data.aws_eks_cluster.default.endpoint
  }
}

data "aws_eks_cluster" "default" {
  name = var.aws_eks_cluster.name
}

data "aws_eks_cluster_auth" "default" {
  name = var.aws_eks_cluster.name
}


resource "helm_release" "metric-server" {
  name       = "metric-server-release"
  repository = "https://charts.bitnami.com/bitnami" 
  chart      = "metrics-server"
  namespace = "kube-system"

  set {
    name  = "apiService.create"
    value = "true"
  }
}