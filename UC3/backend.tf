# Backend Configuration
terraform {
  backend "s3" {
    bucket = "pranjal71025"
    key    = "uc-01/terraform.tfstate"
    region = "us-east-1"
  }
}
