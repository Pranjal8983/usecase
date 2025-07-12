resource "aws_db_subnet_group" "this" {
  name       = "${var.env}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "${var.env}-mysql"
  engine                = "mysql"
  engine_version        = "8.0.41"
  instance_class        = var.db_instance_class
  allocated_storage     = 20
  storage_type          = "gp2"
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  db_subnet_group_name  = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot   = true
  publicly_accessible   = false
  multi_az              = false
  backup_retention_period = 7
  apply_immediately     = true

  tags = {
    Name = "${var.env}-mysql"
  }
}
