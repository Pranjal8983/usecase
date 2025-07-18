output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

output "invoke_url" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute.amazonaws.com/${var.stage_name}/"
}
