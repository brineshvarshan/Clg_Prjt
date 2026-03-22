variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "ecommerce"
}

variable "k8s_context" {
  description = "Kubernetes context"
  type        = string
  default     = "minikube"
}

variable "helm_repo" {
  description = "Helm repository URL (leave empty for local charts)"
  type        = string
  default     = ""
}

variable "helm_chart" {
  description = "Helm chart name or path"
  type        = string
  default     = "../problem-3/helm"
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
  default     = "0.1.0"
}
