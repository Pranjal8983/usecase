test "start_lambda_function_configured_correctly" {
  module = "../"

  variables = {
    lambda_function = {
      start_name = "start-ec2-lambda"
      stop_name  = "stop-ec2-lambda"
      role       = "arn:aws:iam::836837432401:role/Ec2-starrt-lambda"
    }
    instance_id = "i-0f1f515ade621a4ae"
    region      = "us-east-1"
  }

  assert {
    condition = aws_lambda_function.start_lambda.function_name == "start-ec2-lambda"
    message   = "Start Lambda function name should be 'start-ec2-lambda'"
  }

  assert {
    condition = aws_lambda_function.start_lambda.runtime == "python3.9"
    message   = "Start Lambda runtime should be python3.9"
  }

  assert {
    condition = aws_lambda_function.start_lambda.handler == "start_lambda.lambda_handler"
    message   = "Start Lambda handler should be 'start_lambda.lambda_handler'"
  }

  assert {
    condition = aws_lambda_function.start_lambda.environment.variables["instance_id"] == "i-0f1f515ade621a4ae"
    message   = "Start Lambda should have correct instance_id"
  }

  assert {
    condition = aws_lambda_function.start_lambda.environment.variables["region"] == "us-east-1"
    message   = "Start Lambda should have correct region"
  }
}

test "stop_lambda_function_configured_correctly" {
  module = "../"

  variables = {
    lambda_function = {
      start_name = "start-ec2-lambda"
      stop_name  = "stop-ec2-lambda"
      role       = "arn:aws:iam::123456789012:role/lambda-role"
    }
    instance_id = "i-0f1f515ade621a4ae"
    region      = "us-east-1"
  }

  assert {
    condition = aws_lambda_function.stop_lambda.function_name == "stop-ec2-lambda"
    message   = "Stop Lambda function name should be 'stop-ec2-lambda'"
  }

  assert {
    condition = aws_lambda_function.stop_lambda.runtime == "python3.9"
    message   = "Stop Lambda runtime should be python3.9"
  }

  assert {
    condition = aws_lambda_function.stop_lambda.handler == "stop_lambda.lambda_handler"
    message   = "Stop Lambda handler should be 'stop_lambda.lambda_handler'"
  }

  assert {
    condition = aws_lambda_function.stop_lambda.environment.variables["instance_id"] == "i-0f1f515ade621a4ae"
    message   = "Stop Lambda should have correct instance_id"
  }

  assert {
    condition = aws_lambda_function.stop_lambda.environment.variables["region"] == "us-east-1"
    message   = "Stop Lambda should have correct region"
  }
}
