output "lambda_arn" {
  value = aws_lambda_function.container_lambda.arn
}

output "lambda_name" {
  value = aws_lambda_function.container_lambda.function_name
}
