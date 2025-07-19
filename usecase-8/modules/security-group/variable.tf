variable "vpc_id" {
  description = "VPC ID to associate with the security group"
  type        = string
}

variable "alb_sg_name" {
  type = string
  description = "ALB Sg name"
}

variable "sg_name" {
  type = string
  description = "ECS fargate SG name"
}
