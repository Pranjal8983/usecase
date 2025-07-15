resource "aws_s3_bucket" "s3_input_bucket" {
  bucket = var.input_bucket_name
}

resource "aws_s3_bucket" "s3_output_bucket" {
  bucket = var.output_bucket_name
}

