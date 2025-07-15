variable "email" {
  type        = string
  description = "E-mail for subscribing topic"
}

variable "sns_topic_name" {
  type        = string
  description = "SNS topic name"
}

variable "bucket_name" {
  type = string
  description = "bucket name to attach sns"
}
