variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "ecs_security_group" {}
