variable "email" {
  type        = string
  description = "Enamil ID which is need to be subscribed"
}

variable "sns_topic_name" {
  type        = string
  description = "SNS Topic name"
}

variable "bucket_input_name" {
  type        = string
  description = "S3 input Bucket name"
}

variable "bucket_output_name" {
  type        = string
  description = "S3 output Bucket name"
}

variable "lambda_s3_bucket" {
  type        = string
  description = "Lambda Zip file s3 bucket name"
}

variable "lambda_s3_key" {
  type        = string
  description = "Lambda zip s3 path and file name"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name"
}

variable "lambda_role" {
  type        = string
  description = "Lambda IAM role arn"
}
