#Terraform Setup
terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
#AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

#Data Sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}


#VPC Resource
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}


# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

#Public Subnets
resource "aws_subnet" "public" {
  count                     = 2
  vpc_id                    = aws_vpc.main.id
  cidr_block                = var.public_subnet_cidrs[count.index]
  availability_zone         = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch   = true

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    Environment = var.environment
    Type        = "Public"
  }
}
