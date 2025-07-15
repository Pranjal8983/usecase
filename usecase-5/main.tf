module "sns_topic" {
  source         = "./modules/sns"
  sns_topic_name = var.sns_topic_name
  bucket_name = var.bucket_output_name
  email          = var.email
}


module "s3_bucket" {
  source             = "./modules/s3"
  input_bucket_name  = var.bucket_input_name
  output_bucket_name = var.bucket_output_name
  
  enable_event_notification = true
  topic_arn = module.sns_topic.topic_arn
  events =  ["s3:ObjectCreated:*"]
  bucket_depends_on = [module.sns_topic]
}

module "lambda" {
  source      = "./modules/lambda"
  lambda_function = {
    s3_bucket   = var.lambda_s3_bucket
    s3_key      = var.lambda_s3_key
    name        = var.lambda_name
    role        = var.lambda_role
    handler     = "lambda.lambda_handler"
    runtime     = "python3.9"
    memory_size = 128
    timeout     = 30
    publish     = true
  }
  s3_trigger_events = ["s3:ObjectCreated:*"]
  s3_trigger_bucket = var.bucket_input_name
}
