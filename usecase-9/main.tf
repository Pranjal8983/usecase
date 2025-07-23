terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

module "iam" {
  source = "./modules/iam"

  cluster_role_name = "devops-eks-iam-role"
  cluster_assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  node_role_name = "eks-node-group-example"
  node_assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  node_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

module "eks_cluster" {
  source = "./modules/eks-cluster"

  cluster_name     = var.cluster_name
  cluster_role_arn = module.iam.eks_cluster_role_arn
  subnet_ids       = [var.subnet_id_1, var.subnet_id_2]
}

module "eks_node_group" {
  source = "./modules/eks-node-group"

  cluster_name    = var.cluster_name
  node_group_name = "my-workernodes"
  node_role_arn   = module.iam.node_group_role_arn
  subnet_ids      = [var.subnet_id_1, var.subnet_id_2]
  instance_types  = ["t2.medium"]
  desired_size    = 1
  max_size        = 1
  min_size        = 1
}
