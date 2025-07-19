resource "aws_ecs_cluster" "ecs" {
  name = var.cluster_name
}
 
resource "aws_ecs_task_definition" "ecs" {
  for_each = var.services

  family                   = "${var.cluster_name}-${each.key}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_arn_role
 
  container_definitions = jsonencode([
    {
      name      = each.key
      image     = each.value.image
      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol = "tcp"
        }
      ]
      essential = true
    }
  ])
}
 
resource "aws_ecs_service" "ecs" {
  for_each = var.services
  name            = each.key
cluster = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.ecs[each.key].arn
  desired_count   = 1
  launch_type     = "FARGATE"
 
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
 
  load_balancer {
    target_group_arn = each.value.target_group_arn
    container_name = each.key
    container_port = each.value.container_port
  }

  depends_on = [aws_ecs_task_definition.ecs]
}
