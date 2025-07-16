resource "aws_scheduler_schedule" "lambda_trigger" {
  name        = var.name
  description = var.description
  group_name  = "default"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = "Asia/Kolkata"

  target {
    arn      = var.lambda_arn
    role_arn = var.scheduler_role_arn
  }

  state = "ENABLED"
}
