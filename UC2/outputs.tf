output "web_public_ips" {
  description = "Public IP addresses of web servers"
  value       = module.compute.web_public_ips
}

output "db_endpoint" {
  description = "RDS endpoint"
  value       = module.database.db_endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}
