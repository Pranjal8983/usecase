
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
    region = "us-east-1"
}
#create VPC
resource "aws_vpc" "UC1-VPC"{
    cidr_block = "10.10.0.0/16"
    tags = {
    Name = "UC1-VPC"
}
}


#crate subnet

resource "aws_subnet" "UC1-subnet"{
    vpc_id = aws_vpc.UC1-VPC.id
    cidr_block = "10.10.0.0/17"
    tags = {
        Name = "UC1-subnet-automate"
    }
}

#create second subnet

resource "aws_subnet" "UC1-subnet1"{
    vpc_id = aws_vpc.UC1-VPC.id
    cidr_block = "10.10.128.0/18"
    tags = {
        Name = "UC1-subnet-automate1"
    }
}
#create third subnet

resource "aws_subnet" "UC1-subnet2"{
    vpc_id = aws_vpc.UC1-VPC.id
    cidr_block = "10.10.192.0/18"
    tags = {
        Name = "UC1-subnet-automate2"
    }
}

#create IGW
resource "aws_internet_gateway" "UC1-IGW" {
  vpc_id = aws_vpc.UC1-VPC.id

  tags = {
    Name = "Terra-IGW"
  }
}

#route table creation
resource "aws_route_table" "public_RT_terra" {
  vpc_id = aws_vpc.UC1-VPC.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.UC1-IGW.id
  }
 
  tags = { Name = "public_RT_terra" }
}

# Route Table Associations
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.UC1-subnet.id
  route_table_id = aws_route_table.public_RT_terra.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.UC1-subnet1.id
  route_table_id = aws_route_table.public_RT_terra.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.UC1-subnet2.id
  route_table_id = aws_route_table.public_RT_terra.id
}
