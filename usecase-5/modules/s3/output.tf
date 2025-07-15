output "i_bucket" {
  value = aws_s3_bucket.s3_input_bucket.arn
}

output "o_bucket" {
  value = aws_s3_bucket.s3_output_bucket.arn
}
