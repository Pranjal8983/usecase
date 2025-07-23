resource "aws_iam_role" "eks_cluster_role" {
  name = var.cluster_role_name
  assume_role_policy = var.cluster_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role" "node_group_role" {
  name = var.node_role_name
  assume_role_policy = var.node_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "node_group_policies" {
  count      = length(var.node_group_policy_arns)
  policy_arn = var.node_group_policy_arns[count.index]
  role       = aws_iam_role.node_group_role.name
}
