variable "cluster_role_name" {}
variable "cluster_assume_role_policy" {}
variable "node_role_name" {}
variable "node_assume_role_policy" {}
variable "node_group_policy_arns" {
  type = list(string)
}
