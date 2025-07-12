module "network" {
  source          = "./modules/network"
  env             = var.env
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  region          = var.region
}

#security module 
module "security" {
  source     = "./modules/security"
  env        = var.env
  vpc_id     = module.network.vpc_id
  trusted_ips = var.trusted_ips
}

#database module
module "database" {
  source            = "./modules/database"
  env               = var.env
  private_subnet_ids = module.network.private_subnet_ids
  db_sg_id          = module.security.db_sg_id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class
}

#server module
module "server" {
  source           = "./modules/server"
  env              = var.env
  public_subnet_ids = module.network.public_subnet_ids
  web_sg_id        = module.security.web_sg_id
  key_name         = var.key_name
  instance_type    = var.instance_type
}
