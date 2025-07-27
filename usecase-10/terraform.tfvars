# terraform.tfvars

# Basic Configuration
aws_region   = "us-east-1"
project_name = "healthcare"
environment  = "dev"

# Networking Configuration
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

# Service Configuration
appointment_port = 3001
patient_port     = 3000

# ECS Configuration
task_cpu      = "256"    # 0.25 vCPU
task_memory   = "512"    # 0.5 GB
desired_count = 2        # Number of tasks per service
image_tag     = "latest"

# API Gateway Configuration
api_stage_name = "prod"

# Monitoring and Logging
enable_container_insights = true
log_retention_days       = 30
enable_api_gateway_logging = true

# Health Check Configuration
health_check_path                = "/health"
health_check_interval            = 30
health_check_timeout             = 5
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2

# Load Balancer Configuration
enable_deletion_protection        = false
enable_cross_zone_load_balancing = true
deregistration_delay             = 300
enable_http2                     = true
idle_timeout                     = 60

# API Gateway Throttling
api_gateway_throttle_burst_limit = 2000
api_gateway_throttle_rate_limit  = 1000

# Auto Scaling Configuration
auto_scaling_enabled      = true
auto_scaling_min_capacity = 1
auto_scaling_max_capacity = 10
auto_scaling_target_cpu   = 70
auto_scaling_target_memory = 80
scale_up_cooldown         = 300
scale_down_cooldown       = 300

# Platform Configuration
enable_execute_command = false
platform_version      = "LATEST"

# Environment Variables for Services
appointment_environment_variables = {
  NODE_ENV     = "production"
  LOG_LEVEL    = "info"
  SERVICE_NAME = "appointment-service"
  PORT         = "3001"
}

patient_environment_variables = {
  NODE_ENV     = "production"
  LOG_LEVEL    = "info" 
  SERVICE_NAME = "patient-service"
  PORT         = "3000"
}

# Service Discovery (Optional)
enable_service_discovery     = false
service_discovery_namespace = "healthcare.local"

# SSL/TLS Configuration (Optional)
enable_https    = false
certificate_arn = ""  # Add your SSL certificate ARN here if enabling HTTPS

# Security Configuration
enable_waf = false

# API Gateway Advanced Configuration
api_gateway_binary_media_types = [
  "application/octet-stream",
  "image/*",
  "application/pdf"
]
enable_api_caching    = false
api_cache_cluster_size = "0.5"
api_cache_ttl         = 300

# Common Tags
common_tags = {
  Project     = "Healthcare API"
  Environment = "Development"
  ManagedBy   = "Terraform"
  Owner       = "DevOps Team"
  Application = "Healthcare Management System"
  CostCenter  = "Engineering"
}

# Production Configuration (Uncomment and modify for production)
# aws_region = "us-east-1"
# environment = "prod"
# task_cpu = "512"      # 0.5 vCPU
# task_memory = "1024"  # 1 GB
# desired_count = 3
# auto_scaling_min_capacity = 2
# auto_scaling_max_capacity = 20
# enable_deletion_protection = true
# enable_waf = true
# enable_https = true
# certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
# log_retention_days = 90
# enable_api_caching = true
# api_cache_cluster_size = "1.6"

# Development Configuration
# Optimized for cost and development workflow
# task_cpu = "256"
# task_memory = "512"
# desired_count = 1
# auto_scaling_enabled = false
# enable_container_insights = false
# log_retention_days = 7

# Staging Configuration
# aws_region = "us-west-2"
# environment = "staging"
# task_cpu = "512"
# task_memory = "1024"
# desired_count = 2
# auto_scaling_min_capacity = 1
# auto_scaling_max_capacity = 5
# enable_waf = true
# log_retention_days = 30
