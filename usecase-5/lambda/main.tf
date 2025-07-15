resource "aws_lambda_function" "lambda" {
  s3_bucket   = var.lambda_function.s3_bucket
  s3_key      = var.lambda_function.s3_key
  function_name        = var.lambda_function.name
  role        = var.lambda_function.role
  handler     = "lambda.lambda_handler"
  runtime     = "python3.9"
  memory_size = 128
  timeout     = 30
  publish     = true
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id = "AllowExecutionFromS3"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal = "s3.amazonaws.com"
  source_arn = "arn:aws:s3:::${var.s3_trigger_bucket}"
}

resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = var.s3_trigger_bucket
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events = var.s3_trigger_events
  }
  depends_on = [aws_lambda_permission.allow_s3]
}
