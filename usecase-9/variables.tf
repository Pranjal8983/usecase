variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_id_1" {
  description = "First subnet ID for EKS networking"
  type        = string
}

variable "subnet_id_2" {
  description = "Second subnet ID for EKS networking"
  type        = string
}
