variable "lambda_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_role" {
  type        = string
  description = "Lambda IAM role arn"
}

variable "instance_id" {
  type = string
}

variable "region" {
  type = string
}

variable "scheduler_role_arn" {
  type = string
}
