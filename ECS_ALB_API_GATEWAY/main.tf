#with this approach i am trying to deploy microservices in ECS cluster with alb and api gateway
module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source = "./modules/ecs"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "ecr" {
  source = "./modules/ecr"
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  ecs_security_group = module.ecs.security_group_id
}

module "apigateway" {
  source = "./modules/apigateway"
  alb_dns_name = module.alb.alb_dns_name
}
