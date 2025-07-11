#instance type = "t2.medium"
ami_id = "ami-020cba7c55df1f615"
vpc_cidr = "10.0.0.0/16"
azs = [ "us-east-1a" ,"us-east-1b" ]
region = "us-east-1"
vpc_name = "main_vpc"
public_subnets  = [ "10.0.11.0/24" , "10.0.12.0/24" ]
private_subnets = [ "10.0.22.0/24" , "10.0.24.0/24" ]
db_engine = "postgres"
db_password = "9706872312"

