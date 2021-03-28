provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    #cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority.0.data)
    #token                  = data.aws_eks_cluster_auth.default.token
  }
}

data "aws_eks_cluster" "default" {
  name = aws_eks_cluster.demo.name
}

data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.demo.name
}

resource "helm_release" "metric-server" {
  name       = "metric-server-release"
  repository = "${AWS_ACCOUNT_ID}.dkr.ecr.${var.aws_region}.amazonaws.com/${REPO_NAME}" 
  chart      = "metrics-server"
  namespace = "kube-system"

  set {
    name  = "apiService.create"
    value = "true"
  }
}