module "ecr" {
    source = "./modules/ecr"
    repo_name = var.ecr_repo_name
}


module "vpc" {
  source          = "./modules/vpc"
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "sg" {
    source = "./modules/security-group"
    vpc_id = module.vpc.vpc_id
    alb_sg_name = var.alb_sg_name
    sg_name = var.sg_name
}


module "alb" {
  source         = "./modules/alb"
  name           = "uc8-alb"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  alb_sg_id      = module.sg.alb_sg_id
}

module "ecs_cluster" {
  source = "./modules/ecs"
  cluster_name = var.cluster_name
  execution_role_arn = var.execution_role_arn
  task_arn_role = var.execution_role_arn
  subnets = module.vpc.private_subnet_ids
  security_groups = [module.sg.sg_id]

  services = {
    appointments = {
      image = module.ecr.repositories["node-appointment"]
      cpu = 256
      memory = 512
      container_port = 80
      target_group_arn = module.alb.appointments_tg_arn
    }
    patients = {
      image = module.ecr.repositories["node-patient"]
      cpu = 256
      memory = 512
      container_port = 80
      target_group_arn = module.alb.patients_tg_arn
    }
  }
}
