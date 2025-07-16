module "lambda" {
  source = "./modules/lambda"

  lambda_function = {
    start_name = "start-lambda"
    stop_name  = "stop-lambda"
    role       = var.lambda_role
  }
  instance_id = var.instance_id
  region      = var.region
}

module "start_ec2_schedule" {
  source              = "./modules/event"
  name                = "start-ec2-schedule"
  description         = "Trigger Lambda to start EC2"
  schedule_expression = "cron(0/5 * * * ? *)"
  lambda_arn          = module.lambda.start_lambda_function_arn
  lambda_name         = module.lambda.start_lambda_function_name
  scheduler_role_arn  = var.scheduler_role_arn
}

module "stop_ec2_schedule" {
  source              = "./modules/event"
  name                = "stop-ec2-schedule"
  description         = "Trigger Lambda to stop EC2"
  schedule_expression = "cron(0/6 * * * ? *)"
  lambda_arn          = module.lambda.stop_lambda_function_arn
  lambda_name         = module.lambda.stop_lambda_function_name
  scheduler_role_arn  = var.scheduler_role_arn
}
