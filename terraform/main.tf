# Works against ANY Kubernetes cluster -- kind, minikube, Docker Desktop, or a
# managed cloud cluster (GKE/EKS/AKS): just point `kubeconfig_path` at a valid
# kubeconfig file. No cloud-specific resources are used.
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Single source of truth: the same manifests under ../k8s/ are applied here,
# so `kubectl apply -f k8s/` and `terraform apply` always converge on the
# same desired state.
#
# Fallback: if your provider build lacks the kubernetes_manifest resource,
# the community `kubectl` provider (gavinbunney/kubectl) is a drop-in
# alternative -- replace each kubernetes_manifest block with kubectl_manifest
# and keep yamldecode()ing the same files.
resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("${path.module}/../k8s/namespace.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest   = yamldecode(file("${path.module}/../k8s/deployment.yaml"))
  depends_on = [kubernetes_manifest.namespace]
}

resource "kubernetes_manifest" "service" {
  manifest   = yamldecode(file("${path.module}/../k8s/service.yaml"))
  depends_on = [kubernetes_manifest.namespace]
}
