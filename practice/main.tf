provider "aws" {
 # version = "~> 6.0"
  region  = "us-east-1"
}

#=========================
resource "aws_security_group" "pranjal" {
  name        = "pranjal"
}

#==========================
output "security_group_name" {
  value       = aws_security_group.pranjal.name
}
#===========================

