# AWS region
region = "us-east-1"

# VPC CIDR block
vpc_cidr = "10.0.0.0/16"

# Public subnet CIDRs
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

# Private subnet CIDRs
private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

# ECS cluster name
ecs_cluster_name = "private-ecs-cluster"

# ECR repository names
ecr_repositories = [
  "patient-service",
  "appointment-service"
]

# ALB listener ports
patient_service_port    = 3000
appointment_service_port = 3001

# API Gateway route paths
patient_route_path     = "/patient/{proxy+}"
appointment_route_path = "/appointment/{proxy+}"
