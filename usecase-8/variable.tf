variable "ecr_repo_name" {
    type = list(string)
    description = "ECR Repo name list"
}

variable "alb_sg_name" {
    type = string
}

variable "sg_name" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "public_subnets" {
    type = list(string)
}

variable "private_subnets" {
    type = list(string)
}

variable "azs" {
    type = list(string)
}

variable "cluster_name" {
    type = string
}

variable "execution_role_arn" {
    type = string
}
