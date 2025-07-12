variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "trusted_ips" {
  description = "List of trusted IPs for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # only for testing prefered
}
