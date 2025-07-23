output "eks_cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_group_role_arn" {
  description = "IAM role ARN for the EKS node group"
  value       = aws_iam_role.node_group_role.arn
}
