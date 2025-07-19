variable "cluster_name" {
    type = string
}

variable "execution_role_arn" {
    type = string
}

variable "subnets" {
    type = list(string)
}

variable "security_groups" {
    type = list(string)
}

variable "services" {
    type = map(object({
        image = string
        cpu = number
        memory = number
        container_port = number
        target_group_arn = string
    }))
}

variable "task_arn_role"{
    type = string
}
