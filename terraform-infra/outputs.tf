# Output for the Cluster Endpoint
output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

