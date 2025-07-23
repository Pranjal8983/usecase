output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_group_role_arn" {
  description = "IAM role ARN for the EKS node group"
  value       = module.iam.node_group_role_arn
}
