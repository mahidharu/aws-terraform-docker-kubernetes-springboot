

#data "terraform_remote_state" "eks" {
#  backend = "local"

#  config = {
#    path = "../learn-terraform-provision-eks-cluster/terraform.tfstate"
#  }
#}


data "aws_eks_cluster" "cluster" {
#  name = data.terraform_remote_state.eks.outputs.cluster_id
    name = aws_eks_cluster.demo.name
}

provider "kubernetes" {
  load_config_file       = false
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}

resource "kubernetes_deployment" "springboot" {
  metadata {
    name = "scalable-springboot-example"
    labels = {
      App = "ScalableSpringBootExample"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableSpringBootExample"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableSpringBootExample"
        }
      }
      spec {
        container {
          image = "${var.AWS_ACCOUNT_ID}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.REPO_NAME}:latest"
          name  = "springboot"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "springboot" {
  metadata {
    name = "springboot-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.springboot.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}