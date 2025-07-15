variable "input_bucket_name" {
  type        = string
  description = "Input bucket name"
}

variable "output_bucket_name" {
  type        = string
  description = "Output bucket name"
}

variable "topic_arn" {
  type = string
}

variable "events" {
  type = list(string)
  default = ["s3:ObjectCreated:*"]
}

variable "bucket_depends_on" {
  type = any
  default = []
}

variable "enable_event_notification" {
  type = bool
  default = false
}
