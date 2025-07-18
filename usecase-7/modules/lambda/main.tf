resource "aws_lambda_function" "container_lambda" {
  function_name = var.lambda_name
  package_type  = "Image"
  image_uri     = var.image_uri
  role          = aws_iam_role.lambda_exec_role.arn
  timeout       = 30
  memory_size   = 128
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.lambda_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
 
