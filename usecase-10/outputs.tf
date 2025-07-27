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
#=====================IAM Outputs

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.name
}
#================API Endpoints
output "appointment_api_endpoint" {
  description = "Full URL for appointment API endpoint"
  value       = "${aws_api_gateway_stage.main.invoke_url}/appointments"
}

output "patient_api_endpoint" {
  description = "Full URL for patient API endpoint"
  value       = "${aws_api_gateway_stage.main.invoke_url}/patients"
}
#====================Direct ALB Endpoints (for Testing)
output "appointment_alb_endpoint" {
  description = "Direct ALB endpoint for appointment service"
  value       = "http://${aws_lb.main.dns_name}/appointment"
}

output "patient_alb_endpoint" {
  description = "Direct ALB endpoint for patient service"
  value       = "http://${aws_lb.main.dns_name}/patient"
}
#=====================Resource ARNs for Monitoring/Alerting
output "resource_arns" {
  description = "ARNs of key resources for monitoring"
  value = {
    ecs_cluster              = aws_ecs_cluster.main.arn
    appointment_service      = aws_ecs_service.appointment.id
    patient_service          = aws_ecs_service.patient.id
    alb                      = aws_lb.main.arn
    appointment_target_group = aws_lb_target_group.appointment.arn
    patient_target_group     = aws_lb_target_group.patient.arn
    api_gateway              = aws_api_gateway_rest_api.main.arn
    vpc_link                 = aws_api_gateway_vpc_link.main.id
  }
}
#===========================Deployment Information
output "deployment_info" {
  description = "Deployment information"
  value = {
    region           = var.aws_region
    environment      = var.environment
    project_name     = var.project_name
    api_stage        = var.api_stage_name
    desired_count    = var.desired_count
    task_cpu         = var.task_cpu
    task_memory      = var.task_memory
    appointment_port = var.appointment_port
    patient_port     = var.patient_port
  }
}
#=====================Health Check URLs
output "health_check_urls" {
  description = "Health check URLs for services"
  value = {
    appointment_direct = "http://${aws_lb.main.dns_name}/appointment/health"
    patient_direct     = "http://${aws_lb.main.dns_name}/patient/health"
    appointment_api    = "${aws_api_gateway_stage.main.invoke_url}/appointments/health"
    patient_api        = "${aws_api_gateway_stage.main.invoke_url}/patients/health"
  }
}
#====================ECR Login Commands
output "ecr_login_commands" {
  description = "Commands to login to ECR repositories"
  value = {
    appointment = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.appointment.repository_url}"
    patient     = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.patient.repository_url}"
  }
}
#=================Docker Push Commands
output "docker_push_commands" {
  description = "Commands to push Docker images to ECR"
  value = {
    appointment = [
      "docker tag appointment-service:${var.image_tag} ${aws_ecr_repository.appointment.repository_url}:${var.image_tag}",
      "docker push ${aws_ecr_repository.appointment.repository_url}:${var.image_tag}"
    ]
    patient = [
      "docker tag patient-service:${var.image_tag} ${aws_ecr_repository.patient.repository_url}:${var.image_tag}",
      "docker push ${aws_ecr_repository.patient.repository_url}:${var.image_tag}"
    ]
  }
}
#=====================Testing Commands
output "testing_commands" {
  description = "Commands to test the deployed services"
  value = {
    appointment_get  = "curl -X GET ${aws_api_gateway_stage.main.invoke_url}/appointments"
    patient_get      = "curl -X GET ${aws_api_gateway_stage.main.invoke_url}/patients"
    appointment_post = "curl -X POST ${aws_api_gateway_stage.main.invoke_url}/appointments -H 'Content-Type: application/json' -d '{\"patientId\": \"123\", \"doctorId\": \"456\", \"datetime\": \"2024-01-15T10:00:00Z\"}'"
    patient_post     = "curl -X POST ${aws_api_gateway_stage.main.invoke_url}/patients -H 'Content-Type: application/json' -d '{\"name\": \"John Doe\", \"age\": 30, \"email\": \"john@example.com\"}'"
  }
}
#===================Monitoring URLs
output "monitoring_urls" {
  description = "URLs for monitoring and logging"
  value = {
    cloudwatch_logs_appointment = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#logsV2:log-groups/log-group/${replace(aws_cloudwatch_log_group.appointment.name, "/", "$252F")}"
    cloudwatch_logs_patient     = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#logsV2:log-groups/log-group/${replace(aws_cloudwatch_log_group.patient.name, "/", "$252F")}"
    cloudwatch_logs_api_gateway = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#logsV2:log-groups/log-group/${replace(aws_cloudwatch_log_group.api_gateway.name, "/", "$252F")}"
    ecs_cluster                 = "https://${var.aws_region}.console.aws.amazon.com/ecs/home?region=${var.aws_region}#/clusters/${aws_ecs_cluster.main.name}/services"
    api_gateway                 = "https://${var.aws_region}.console.aws.amazon.com/apigateway/home?region=${var.aws_region}#/apis/${aws_api_gateway_rest_api.main.id}/stages/${var.api_stage_name}"
    load_balancer               = "https://${var.aws_region}.console.aws.amazon.com/ec2/home?region=${var.aws_region}#LoadBalancers:search=${aws_lb.main.name}"
  }
}
#=====================
