module "ec-2" {
  source         = "./modules/ec-2"
  instance_type  = var.instance_type
  ami_id         = var.ami_id
  instance_count = var.instance_count
}

module "lambda_start" {
  source             = "./modules/lambda"
  function_name      = "start-ec2"
  handler            = "start_ec2.lambda_handler"
  runtime            = var.lambda_runtime
  lambda_source      = "${path.module}/modules/lambda/start_ec2.py"
  ec2_instance_id    = module.ec2.instance_id 
  action             = "start"
}

module "lambda_stop" {
  source             = "./modules/lambda"
  function_name      = "stop-ec2"
  handler            = "stop_ec2.lambda_handler"
  runtime            = var.lambda_runtime
  lambda_source      = "${path.module}/modules/lambda/stop_ec2.py"
  ec2_instance_id    = module.ec2.instance_id 
  action             = "stop"
}

module "scheduler_start" {
  source               = "./modules/scheduler"
  rule_name            = "start-ec2-schedule"
  schedule_expression  = var.start_cron
  lambda_function_arn  = module.lambda_start.lambda_function_arn
}

module "scheduler_stop" {
  source               = "./modules/scheduler"
  rule_name            = "stop-ec2-schedule"
  schedule_expression  = var.stop_cron
  lambda_function_arn  = module.lambda_stop.lambda_function_arn
}
