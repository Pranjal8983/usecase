module "lambda" {
  source      = "./modules/lambda"
  lambda_name = var.name
  image_uri   = var.image
}

module "api_gateway" {
  source               = "./modules/apigateway"
  api_name             = var.api_name
  stage_name           = "dev"
  resource_path        = ""
  lambda_invoke_arn    = module.lambda.lambda_arn
  lambda_function_name = module.lambda.lambda_name
}
