output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "invoke_url" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.us-east-1.amazonaws.com/${var.stage_name}/"
}
