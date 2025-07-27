# variables.tf

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "healthcare"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "appointment_port" {
  description = "Port for appointment service"
  type        = number
  default     = 3001
}

variable "patient_port" {
  description = "Port for patient service"
  type        = number
  default     = 3000
}

variable "task_cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memory for ECS task"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}

variable "api_stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "prod"
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Health check path for services"
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health checks required to mark target healthy"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required to mark target unhealthy"
  type        = number
  default     = 2
}

variable "enable_api_gateway_logging" {
  description = "Enable API Gateway access logging"
  type        = bool
  default     = true
}

variable "api_gateway_throttle_burst_limit" {
  description = "API Gateway throttle burst limit"
  type        = number
  default     = 2000
}

variable "api_gateway_throttle_rate_limit" {
  description = "API Gateway throttle rate limit"
  type        = number
  default     = 1000
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for ALB"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
  default     = true
}

variable "deregistration_delay" {
  description = "Time for load balancer to wait before changing state of deregistering target"
  type        = number
  default     = 300
}

variable "enable_http2" {
  description = "Enable HTTP/2 on ALB"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "Time in seconds that connection is allowed to be idle"
  type        = number
  default     = 60
}

variable "enable_waf" {
  description = "Enable AWS WAF for API Gateway"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "Healthcare API"
    ManagedBy   = "Terraform"
    Owner       = "DevOps Team"
  }
}

variable "auto_scaling_enabled" {
  description = "Enable auto scaling for ECS services"
  type        = bool
  default     = true
}

variable "auto_scaling_min_capacity" {
  description = "Minimum number of tasks for auto scaling"
  type        = number
  default     = 1
}

variable "auto_scaling_max_capacity" {
  description = "Maximum number of tasks for auto scaling"
  type        = number
  default     = 10
}

variable "auto_scaling_target_cpu" {
  description = "Target CPU utilization for auto scaling"
  type        = number
  default     = 70
}

variable "auto_scaling_target_memory" {
  description = "Target memory utilization for auto scaling"
  type        = number
  default     = 80
}

variable "scale_up_cooldown" {
  description = "Cooldown period after scale up in seconds"
  type        = number
  default     = 300
}

variable "scale_down_cooldown" {
  description = "Cooldown period after scale down in seconds"
  type        = number
  default     = 300
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for debugging"
  type        = bool
  default     = false
}

variable "platform_version" {
  description = "Fargate platform version"
  type        = string
  default     = "LATEST"
}

variable "appointment_environment_variables" {
  description = "Environment variables for appointment service"
  type        = map(string)
  default = {
    NODE_ENV = "production"
    LOG_LEVEL = "info"
  }
}

variable "patient_environment_variables" {
  description = "Environment variables for patient service"
  type        = map(string)
  default = {
    NODE_ENV = "production"
    LOG_LEVEL = "info"
  }
}

variable "enable_service_discovery" {
  description = "Enable service discovery"
  type        = bool
  default     = false
}

variable "service_discovery_namespace" {
  description = "Service discovery namespace"
  type        = string
  default     = "healthcare.local"
}

variable "certificate_arn" {
  description = "SSL certificate ARN for HTTPS listener"
  type        = string
  default     = ""
}

variable "enable_https" {
  description = "Enable HTTPS listener on ALB"
  type        = bool
  default     = false
}

variable "api_gateway_binary_media_types" {
  description = "Binary media types for API Gateway"
  type        = list(string)
  default     = ["application/octet-stream", "image/*"]
}

variable "enable_api_caching" {
  description = "Enable API Gateway caching"
  type        = bool
  default     = false
}

variable "api_cache_cluster_size" {
  description = "API Gateway cache cluster size"
  type        = string
  default     = "0.5"
}

variable "api_cache_ttl" {
  description = "API Gateway cache TTL in seconds"
  type        = number
  default     = 300
}
