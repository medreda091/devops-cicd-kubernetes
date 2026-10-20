variable "kubeconfig_path" {
  description = "Path to the kubeconfig file of the target cluster (kind, minikube, cloud...)."
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Kubernetes namespace for the demo-api resources."
  type        = string
  default     = "demo-api"
}

variable "image" {
  description = "Container image deployed by the demo-api Deployment."
  type        = string
  default     = "ghcr.io/medreda091/demo-api:latest"
}
