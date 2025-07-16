output "start_lambda_function_arn" {
  value = aws_lambda_function.start_lambda.arn
}

output "start_lambda_function_name" {
  value = aws_lambda_function.start_lambda.function_name
}

output "stop_lambda_function_arn" {
  value = aws_lambda_function.stop_lambda.arn
}

output "stop_lambda_function_name" {
  value = aws_lambda_function.stop_lambda.function_name
}
