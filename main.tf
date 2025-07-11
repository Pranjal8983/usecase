provider "aws" {
  region = var.region
}
module "ec2" {
  source         = "./module/ec2"
  ami_id         = var.ami_id
  vpc_id         = module.vpc.vpc_id
  sg_id          = module.security_group.sg_id
  public_subnets = module.vpc.public_subnet_ids
}

module "security_group" {
  source = "./module/security-group"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source          = "./module/vpc"
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}


module "rds" {
  source               = "./module/rds"
  db_identifier        = "my-db-instance"
  db_engine            = "postgres"
  db_instance_class    = "db.t3.micro"
  db_allocated_storage = 5
  db_username          = "arun"
  name                 = "test"
  db_password          = var.db_password
  db_subnet_group_name = "my-db-subnet-group"
  private_subnet_ids   = module.vpc.private_subnet_ids
  security_group_ids   = [module.security_group.rds_sg_id]
  multi_az             = false
  tags = {
    Environment = "test"
    Project     = "my-project"
  }
}
