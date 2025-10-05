# ALB
resource "aws_lb" "elb" {
  name = "${var.elb_name_prefix}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.elb_sg_id]
  subnets = var.elb_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "${var.elb_name_prefix}-alb"
  }
}

# ALBターゲットグループ
resource "aws_lb_target_group" "elb_tg" {
  name = "${var.elb_name_prefix}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 30
    matcher = "200"
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.elb_name_prefix}-tg"
  }
}

# ALBリスナー（HTTP:80）
resource "aws_lb_listener" "elb_http" {
  load_balancer_arn = aws_lb.elb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# ALBリスナー（HTTPS:443）
resource "aws_lb_listener" "elb_https" {
  load_balancer_arn = aws_lb.elb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.api_certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.elb_tg.arn
  }
}