#=====VPC Outputs====
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

#===========Security Group Outputs
output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "ecs_security_group_id" {
  description = "ID of the ECS security group"
  value       = aws_security_group.ecs.id
}
#=============ECR Outputs
output "appointment_ecr_repository_url" {
  description = "URL of the appointment ECR repository"
  value       = aws_ecr_repository.appointment.repository_url
}

output "patient_ecr_repository_url" {
  description = "URL of the patient ECR repository"
  value       = aws_ecr_repository.patient.repository_url
}

output "appointment_ecr_repository_arn" {
  description = "ARN of the appointment ECR repository"
  value       = aws_ecr_repository.appointment.arn
}

output "patient_ecr_repository_arn" {
  description = "ARN of the patient ECR repository"
  value       = aws_ecr_repository.patient.arn
}
#=====================ECS Outputs
output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main.arn
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "appointment_task_definition_arn" {
  description = "ARN of the appointment task definition"
  value       = aws_ecs_task_definition.appointment.arn
}

output "patient_task_definition_arn" {
  description = "ARN of the patient task definition"
  value       = aws_ecs_task_definition.patient.arn
}

output "appointment_service_id" {
  description = "ID of the appointment ECS service"
  value       = aws_ecs_service.appointment.id
}

output "patient_service_id" {
  description = "ID of the patient ECS service"
  value       = aws_ecs_service.patient.id
}

output "appointment_service_name" {
  description = "Name of the appointment ECS service"
  value       = aws_ecs_service.appointment.name
}

output "patient_service_name" {
  description = "Name of the patient ECS service"
  value       = aws_ecs_service.patient.name
}
#============Load Balancer Outputs
output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.main.id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "appointment_target_group_arn" {
  description = "ARN of the appointment target group"
  value       = aws_lb_target_group.appointment.arn
}

output "patient_target_group_arn" {
  description = "ARN of the patient target group"
  value       = aws_lb_target_group.patient.arn
}
#=======================API Gateway Outputs
output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = aws_api_gateway_rest_api.main.id
}

output "api_gateway_arn" {
  description = "ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.arn
}

output "api_gateway_execution_arn" {
  description = "Execution ARN of the API Gateway"
  value       = aws_api_gateway_rest_api.main.execution_arn
}

output "api_gateway_invoke_url" {
  description = "Invoke URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.main.id}.execute-api.${var.aws_region}.amazonaws.com/${var.api_stage_name}"
}

output "api_gateway_stage_arn" {
  description = "ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.main.arn
}

output "api_gateway_stage_invoke_url" {
  description = "Invoke URL of the API Gateway stage"
  value       = aws_api_gateway_stage.main.invoke_url
}

output "vpc_link_id" {
  description = "ID of the VPC Link"
  value       = aws_api_gateway_vpc_link.main.id
}
#===================CloudWatch Outputs
output "appointment_log_group_name" {
  description = "Name of the appointment CloudWatch log group"
  value       = aws_cloudwatch_log_group.appointment.name
}

output "patient_log_group_name" {
  description = "Name of the patient CloudWatch log group"
  value       = aws_cloudwatch_log_group.patient.name
}

output "api_gateway_log_group_name" {
  description = "Name of the API Gateway CloudWatch log group"
  value       = aws_cloudwatch_log_group.api_gateway.name
}

output "appointment_log_group_arn" {
  description = "ARN of the appointment CloudWatch log group"
  value       = aws_cloudwatch_log_group.appointment.arn
}

output "patient_log_group_arn" {
  description = "ARN of the patient CloudWatch log group"
  value       = aws_cloudwatch_log_group.patient.arn
}
#=====================
