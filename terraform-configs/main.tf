terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.k8s_context
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = var.k8s_context
  }
}

# Create namespace
resource "kubernetes_namespace" "ecommerce" {
  metadata {
    name = var.namespace
  }
}

# Deploy secure-ecommerce with Helm
resource "helm_release" "ecommerce" {
  name             = "secure-ecommerce"
  repository       = var.helm_repo
  chart            = var.helm_chart
  namespace        = kubernetes_namespace.ecommerce.metadata[0].name
  version          = var.chart_version
  create_namespace = false

  values = [
    file("${path.module}/../problem-3/helm/values.yaml")
  ]

  depends_on = [kubernetes_namespace.ecommerce]
}

# Output service details
output "service_name" {
  value       = helm_release.ecommerce.status[0].metadata[0].name
  description = "Service name"
}

output "namespace" {
  value       = kubernetes_namespace.ecommerce.metadata[0].name
  description = "Kubernetes namespace"
}
