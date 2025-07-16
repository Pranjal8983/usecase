data "archive_file" "start_lambda" {
  type        = "zip"
  source_file = "${path.module}/start_lambda.py"
  output_path = "${path.module}/start_lambda.zip"
}

data "archive_file" "stop_lambda" {
  type        = "zip"
  source_file = "${path.module}/stop_lambda.py"
  output_path = "${path.module}/stop_lambda.zip"
}


resource "aws_lambda_function" "start_lambda" {
  function_name = var.lambda_function.start_name
  role          = var.lambda_function.role
  handler       = "start_lambda.lambda_handler"
  runtime       = "python3.9"
  memory_size   = 128
  timeout       = 30
  publish       = true
  filename      = data.archive_file.start_lambda.output_path
  environment {
    variables = {
      instance_id = var.instance_id
      region      = var.region
    }
  }
}

resource "aws_lambda_function" "stop_lambda" {
  function_name = var.lambda_function.stop_name
  role          = var.lambda_function.role
  handler       = "stop_lambda.lambda_handler"
  runtime       = "python3.9"
  memory_size   = 128
  timeout       = 30
  publish       = true
  filename      = data.archive_file.stop_lambda.output_path
  environment {
    variables = {
      instance_id = var.instance_id
      region      = var.region
    }
  }
}
