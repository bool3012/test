######################
# ALB SECURITY GROUP #
######################

resource "aws_security_group" "alb" {
  count = var.create ? 1 : 0

  name        = format("%s-%s-ALB-SG", local.prefix, local.name)
  description = format("%s Load Balancer", local.name)
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags_as_map,
    {
      "Name" = format("%s-%s-ALB-SG", local.prefix, local.name)
    },
    {
      "ResourceName" = format("%s-%s-ALB-SG", local.prefix, local.name)
    },
    {
      "VPCID" = var.vpc_id
    },
    {
      "ResourceType" = "SG"
    },
  )
}

resource "aws_security_group_rule" "elb_out_to_ec2" {
  count = var.create ? 1 : 0

  security_group_id        = aws_security_group.alb[0].id
  description              = "HTTP to instances"
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.ec2[0].id
}

#------------------------------------------------------------

######################
# EC2 SECURITY GROUP #
######################

resource "aws_security_group" "ec2" {
  count = var.create ? 1 : 0

  name        = format("%s-%s-EC2-SG", local.prefix, local.name)
  description = "${local.name} instances"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags_as_map,
    {
      "Name" = format("%s-%s-EC2-SG", local.prefix, local.name)
    },
    {
      "ResourceName" = format("%s-%s-EC2-SG", local.prefix, local.name)
    },
    {
      "VPCID" = var.vpc_id
    },
    {
      "ResourceType" = "SG"
    },
  )
}

resource "aws_security_group_rule" "ec2_in_ssh_restrict" {
  count = var.create ? 1 : 0

  security_group_id        = aws_security_group.ec2[0].id
  description              = "SSH traffic"
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = var.ssh_source_restriction
}

resource "aws_security_group_rule" "ec2_in_http" {
  count = var.create ? 1 : 0

  security_group_id        = aws_security_group.ec2[0].id
  description              = "HTTP in from ALB"
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb[0].id
}

resource "aws_security_group_rule" "ec2_in_https" {
  count = var.create ? 1 : 0

  security_group_id        = aws_security_group.ec2[0].id
  description              = "HTTPS in from ALB"
  type                     = "ingress"
  protocol                 = "TCP"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.alb[0].id
}
/*
    EGRESS traffic

    We allow this traffic out for EC2 instances:
        - TCP traffic out to corporate proxies
        - Traffic to VPC endpoints (located in our VPC)
*/

resource "aws_security_group_rule" "ec2_out_any" {
  count = var.create ? 1 : 0

  security_group_id = aws_security_group.ec2[0].id
  description       = "Traffic out"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "in_https" {
  count = var.create && var.public ? 1 : 0

  security_group_id = element(concat(aws_security_group.alb.*.id, [""]), 0)
  description       = "HTTPS to ALB"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"] # Allow all, the restriction is managed by waf-regional.tf
}

