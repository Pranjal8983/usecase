resource "aws_apigatewayv2_api" "http_api" {
  name          = "http-proxy-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "http://${var.alb_dns_name}"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "patient_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /patient/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

resource "aws_apigatewayv2_route" "appointment_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /appointment/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}
