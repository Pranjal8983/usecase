variable "lambda_function" {
  type = object({
    start_name = string
    stop_name  = string
    role       = string
  })
}

variable "instance_id" {
  type        = string
  description = "Instance ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}
