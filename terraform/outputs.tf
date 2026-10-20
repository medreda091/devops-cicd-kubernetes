output "namespace" {
  description = "Namespace where demo-api was deployed."
  value       = var.namespace
}

output "service_name" {
  description = "Name of the ClusterIP Service fronting demo-api."
  value       = "demo-api"
}

output "image" {
  description = "Container image deployed."
  value       = var.image
}
