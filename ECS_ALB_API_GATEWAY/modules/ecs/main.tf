resource "aws_ecs_cluster" "main" {
  name = "private-ecs-cluster"
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 3000
    to_port   = 3001
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
