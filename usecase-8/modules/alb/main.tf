resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnets

  tags = {
    Name = var.name
  }
}

# Target Groups

resource "aws_lb_target_group" "patients" {
  name     = "${var.name}-tg-patients"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/health"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "appointments" {
  name     = "${var.name}-tg-appointments"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

    health_check {
    path = "/health"
    protocol = "HTTP"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol         = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Please enter valid path"
      status_code = "503"
    }
  }
}


resource "aws_lb_listener_rule" "patients" {
  listener_arn = aws_lb_listener.http.arn
  priority = 10

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.patients.arn
  }

  condition {
    path_pattern {
      values = ["/patients"]
    }
  }
}

resource "aws_lb_listener_rule" "appointments" {
  listener_arn = aws_lb_listener.http.arn
  priority = 11

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.appointments.arn
  }

  condition {
    path_pattern {
      values = ["/appointments"]
    }
  }
}
