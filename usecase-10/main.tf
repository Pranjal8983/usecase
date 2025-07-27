#Terraform Setup
terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
#AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

#Data Sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}


#VPC Resource
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}


# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}

#Public Subnets
resource "aws_subnet" "public" {
  count                     = 2
  vpc_id                    = aws_vpc.main.id
  cidr_block                = var.public_subnet_cidrs[count.index]
  availability_zone         = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch   = true

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}"
    Environment = var.environment
    Type        = "Public"
  }
}
#================Private Subnets
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}"
    Environment = var.environment
    Type        = "Private"
  }
}

#===============Elastic IPs for NAT Gateways================
resource "aws_eip" "nat" {
  count      = 2
  domain     = "vpc"
  depends_on = [aws_internet_gateway.main]

  tags = {
    Name        = "${var.project_name}-nat-eip-${count.index + 1}"
    Environment = var.environment
  }
}
#===================nat gateway==================
resource "aws_nat_gateway" "main" {
  count         = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name        = "${var.project_name}-nat-gateway-${count.index + 1}"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]
}

#=======================Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}

#================Private Route Tables
resource "aws_route_table" "private" {
  count  = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name        = "${var.project_name}-private-rt-${count.index + 1}"
    Environment = var.environment
  }
}

#===================Route Table Associations
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
#===========================ALB Security Group

resource "aws_security_group" "alb" {
  name_prefix = "${var.project_name}-alb-"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-alb-sg"
    Environment = var.environment
  }
}

#======================ECS Security Group
resource "aws_security_group" "ecs" {
  name_prefix = "${var.project_name}-ecs-"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Appointment Service"
    from_port       = var.appointment_port
    to_port         = var.appointment_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    description     = "Patient Service"
    from_port       = var.patient_port
    to_port         = var.patient_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
   _port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-ecs-sg"
    Environment = var.environment
  }
}

#==================================ECR Repositories====Appointment Service
resource "aws_ecr_repository" "appointment" {
  name                     = "${var.project_name}-appointment-service"
  image_tag_mutability    = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = var.environment
  }
}

#=========================Patient Service
resource "aws_ecr_repository" "patient" {
  name                     = "${var.project_name}-patient-service"
  image_tag_mutability    = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Environment = var.environment
  }
}

#=================ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Environment = var.environment
  }
}
#====================ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
#==========================
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#====================CloudWatch Log Groups

resource "aws_cloudwatch_log_group" "appointment" {
  name              = "/ecs/${var.project_name}-appointment"
  retention_in_days = 30
  tags = {
    Environment = var.environment
  }
}

resource "aws_cloudwatch_log_group" "patient" {
  name              = "/ecs/${var.project_name}-patient"
  retention_in_days = 30
  tags = {
    Environment = var.environment
  }
}

#================ECS Task Definition: Appointment Service
resource "aws_ecs_task_definition" "appointment" {
  family                   = "${var.project_name}-appointment-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "appointment-container"
      image = "${aws_ecr_repository.appointment.repository_url}:${var.image_tag}"
      portMappings = [
        {
          containerPort = var.appointment_port
          hostPort      = var.appointment_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.appointment.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = [
        {
          name  = "PORT"
          value = tostring(var.appointment_port)
        },
        {
          name  = "NODE_ENV"
          value = var.environment
        }
      ]
      healthCheck = {
        command  = ["CMD-SHELL", "curl -f  || exit 1"]
        interval = 30
        timeout  = 5
        retries  = 3
      }
    }
  ])

  tags = {
    Environment = var.environment
  }
}
#===============================ECS Task Definition: Patient Service
resource "aws_ecs_task_definition" "patient" {
  family                   = "${var.project_name}-patient-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "patient-container"
      image = "${aws_ecr_repository.patient.repository_url}:${var.image_tag}"
      portMappings = [
        {
          containerPort = var.patient_port
          hostPort      = var.patient_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.patient.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = [
        {
          name  = "PORT"
          value = tostring(var.patient_port)
        },
        {
          name  = "NODE_ENV"
          value = var.environment
        }
      ]
      healthCheck = {
        command  = ["CMD-SHELL", "curl -f  || exit 1"]
        interval = 30
        timeout  = 5
        retries  = 3
      }
    }
  ])

  tags = {
    Environment = var.environment
  }
}
#===============Application Load Balancer
resource "aws_lb" "main" {
  name                   = "${var.project_name}-alb"
  internal               = false
  load_balancer_type     = "application"
  security_groups        = [aws_security_group.alb.id]
  subnets                = aws_subnet.public[*].id
  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}
#======================Appointment Service Target Group

resource "aws_lb_target_group" "appointment" {
  name        = "${var.project_name}-appointment-tg"
  port        = var.appointment_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Environment = var.environment
  }
}

#==================================Patient Service Target Group
resource "aws_lb_target_group" "patient" {
  name        = "${var.project_name}-patient-tg"
  port        = var.patient_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Environment = var.environment
  }
}
#========================Load Balancer Listener
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}
#=======================Appointment Service Rule
resource "aws_lb_listener_rule" "appointment" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.appointment.arn
  }

  condition {
    path_pattern {
      values = ["/appointment*"]
    }
  }
}
#============================Patient Service Rule
resource "aws_lb_listener_rule" "patient" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.patient.arn
  }

  condition {
    path_pattern {
      values = ["/patient*"]
    }
  }
}
#ECS service========Appointment Service===========
resource "aws_ecs_service" "appointment" {
  name            = "${var.project_name}-appointment-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appointment.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups   = [aws_security_group.ecs.id]
    subnets           = aws_subnet.private[*].id
    assign_public_ip  = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.appointment.arn
    container_name   = "appointment-container"
    container_port   = var.appointment_port
  }

  depends_on = [aws_lb_listener.main]

  tags = {
    Environment = var.environment
  }
}
#==========Patient Service
resource "aws_ecs_service" "patient" {
  name            = "${var.project_name}-patient-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.patient.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups   = [aws_security_group.ecs.id]
    subnets           = aws_subnet.private[*].id
    assign_public_ip  = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.patient.arn
    container_name   = "patient-container"
    container_port   = var.patient_port
  }

  depends_on = [aws_lb_listener.main]

  tags = {
    Environment = var.environment
  }
}
#===============================VPC Link for API Gateway
resource "aws_api_gateway_vpc_link" "main" {
  name        = "${var.project_name}-vpc-link"
  description = "VPC link for healthcare API"
  target_arns = [aws_lb.main.arn]

  tags = {
    Environment = var.environment
  }
}

#============================API Gateway
resource "aws_api_gateway_rest_api" "main" {
  name        = "${var.project_name}-api"
  description = "Healthcare API Gateway"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Environment = var.environment
  }
}
#================================ API Gateway Resources
resource "aws_api_gateway_resource" "appointments" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "appointments"
}

resource "aws_api_gateway_resource" "appointments_proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.appointments.id
  path_part   = "{proxy+}"
}
#====================Patients===========
resource "aws_api_gateway_resource" "patients" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "patients"
}

resource "aws_api_gateway_resource" "patients_proxy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.patients.id
  path_part   = "{proxy+}"
}

#===============API Gateway Methods
resource "aws_api_gateway_method" "appointments_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.appointments_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "patients_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.patients_proxy.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}
#=========================API Gateway Integrations
resource "aws_api_gateway_integration" "appointments" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.appointments_proxy.id
  http_method             = aws_api_gateway_method.appointments_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://${aws_lb.main.dns_name}/appointment/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_integration" "patients" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.patients_proxy.id
  http_method             = aws_api_gateway_method.patients_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://${aws_lb.main.dns_name}/patient/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

#==================Deployment
resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    aws_api_gateway_integration.appointments,
    aws_api_gateway_integration.patients
  ]
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = "prod"
}
#==============API Gateway Deployment
#resource "aws_api_gateway_deployment" "main" {
 # depends_on = [
  #  aws_api_gateway_integration.appointments,
   # aws_api_gateway_integration.patients,
  #]
  #rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.appointments.id,
      aws_api_gateway_resource.patients.id,
      aws_api_gateway_method.appointments_any.id,
      aws_api_gateway_method.patients_any.id,
      aws_api_gateway_integration.appointments.id,
      aws_api_gateway_integration.patients.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}
#==================== API Gateway Stage
resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = var.api_stage_name

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format = jsonencode({
      requestId       = "$context.requestId"
      ip              = "$context.identity.sourceIp"
      caller          = "$context.identity.caller"
      user            = "$context.identity.user"
      requestTime     = "$context.requestTime"
      httpMethod      = "$context.httpMethod"
      resourcePath    = "$context.resourcePath"
      status          = "$context.status"
      protocol        = "$context.protocol"
      responseLength  = "$context.responseLength"
    })
  }

  tags = {
    Environment = var.environment
  }
}
#====================CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/${var.project_name}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}
#=========================

