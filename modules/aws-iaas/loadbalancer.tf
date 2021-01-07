# Deploys an Application Load Balancer
resource "aws_alb" "alb" {
  count = var.create ? 1 : 0

  name                             = format("%s-%s-ALB", local.prefix, local.name)
  internal                         = var.public ? false : true
  subnets                          = var.elb_subnets
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  # The security group for the load balancer.
  # This will configure the module's ALB security group and additional SGs
  # passed with the 'elb_security_groups' variable.
  security_groups = concat([aws_security_group.alb[0].id], flatten(var.elb_security_groups))

  enable_deletion_protection = false

  # Access logs
  access_logs {
    enabled = true
    bucket  = var.elb_log_bucket
    prefix  = var.elb_log_prefix
  }

  tags = merge(
    var.tags_as_map,
    {
      "Name" = format("%s-%s-ALB", local.prefix, local.name)
    },
    {
      "ResourceName" = format("%s-%s-ALB", local.prefix, local.name)
    },
    {
      "VPCID" = var.vpc_id
    },
    {
      "ResourceType" = "ALB"
    },
  )
}

# Load balancer HTTPS listener.
# Created only if create==True and the SSL/TLS certificate ARN is not empty.
resource "aws_lb_listener" "https" {
  count = var.create && length(var.ssl_cert_arn) > 0 ? 1 : 0

  load_balancer_arn = aws_alb.alb[0].arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_cert_arn

  # Forward traffic to the backend EC2 instance using HTTP
  default_action {
    target_group_arn = aws_alb_target_group.http[0].arn
    type             = "forward"
  }
}
#stockexlocal cert
resource "aws_lb_listener_certificate" "stockexlocal_balancers" {
  count = var.elb_stockex_certificate_arn == "" ? 0 : 1
  listener_arn = aws_lb_listener.https[0].arn
  certificate_arn = var.elb_stockex_certificate_arn
}
# Load balancer HTTP listener
resource "aws_lb_listener" "http" {
  count = var.create || length(var.ssl_cert_arn) < 1 ? 1 : 0

  load_balancer_arn = aws_alb.alb[0].arn
  port              = "80"
  protocol          = "HTTP"

  # Forward traffic to the backend EC2 instance using HTTP
  default_action {
    target_group_arn = aws_alb_target_group.http[0].arn
    type             = "forward"
  }
}

# HTTP Target Group
resource "aws_alb_target_group" "http" {
  count = var.create ? 1 : 0

  name        = format("%s-%s-HTTP-TGTGRP", local.prefix, local.name)
  vpc_id      = var.vpc_id
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.cookie_duration
    enabled         = var.stickiness_enable
  }

  # Configure health check of resource
  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = var.health_check_timeout # Fails health check after this amount of time without response
    healthy_threshold   = var.health_check_healthy
    unhealthy_threshold = var.health_check_unhealthy
    matcher             = "200" # can provide multiple or range values: 200,202  or   200-299
  }

  tags = merge(
    var.tags_as_map,
    {
      "Name" = format("%s-%s-HTTP-TGTGRP", local.prefix, local.name)
    },
    {
      "ResourceName" = format("%s-%s-HTTP-TGTGRP", local.prefix, local.name)
    },
    {
      "VPCID" = var.vpc_id
    },
    {
      "ResourceType" = "TARGETGROUP"
    },
  )
}

