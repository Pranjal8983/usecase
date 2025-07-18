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
resource "aws_lb_target_group" "default" {
  name     = "${var.name}-tg-default"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "images" {
  name     = "${var.name}-tg-images"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "register" {
  name     = "${var.name}-tg-register"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}

# Listener Rules
resource "aws_lb_listener_rule" "images" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.images.arn
  }

  condition {
    path_pattern {
      values = ["/images*"]
    }
  }
}

resource "aws_lb_listener_rule" "register" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.register.arn
  }

  condition {
    path_pattern {
      values = ["/register*"]
    }
  }
}

resource "aws_lb_target_group_attachment" "default" {
  target_group_arn = aws_lb_target_group.default.arn
  target_id        = var.instance_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "images" {
  target_group_arn = aws_lb_target_group.images.arn
  target_id        = var.instance_ids[1]
  port             = 80
}

resource "aws_lb_target_group_attachment" "register" {
  target_group_arn = aws_lb_target_group.register.arn
  target_id        = var.instance_ids[2]
  port             = 80
}
