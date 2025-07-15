variable "lambda_function" {
  type = object({
    s3_bucket = string
    s3_key    = string
    name      = string
    role      = string
  })
}

variable "s3_trigger_bucket"{
    type = string
    description = "S3 bucket trigger bucket"
}

variable "s3_trigger_events" {
    type = list(string)
    description = "S3 event list"
}

variable "enable_s3_trigger" {
    type = bool
    default = false
}
