# Create security group for the instance
resource "aws_security_group" "ec2" {
  count = var.create ? 1 : 0

  name        = format("%s-EC2-SG", local.prefix)
  vpc_id      = var.vpc_id
  description = "Allowed traffic to/from ${var.name} instance"

  tags = merge(
    var.tags,
    {
      "Name" = format("%s-EC2-SG", local.prefix)
    },
    {
      "ResourceName" = format("%s-EC2-SG", local.prefix)
    },
    {
      "ResourceType" = "SG"
    },
  )
}

resource "aws_security_group_rule" "in_ssh_sg" {
  count = var.create ? 1 : 0

  security_group_id        = aws_security_group.ec2[0].id
  description              = "Enables SSH management traffic"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.ssh_port
  to_port                  = var.ssh_port
  source_security_group_id = var.ssh_source_restriction
}

resource "aws_security_group_rule" "in_ssh_cidr" {
  count = var.create ? length(var.ssh_allowed_cidrs) : 0

  security_group_id = aws_security_group.ec2[0].id

  description = "Enables SSH management traffic"
  type        = "ingress"
  protocol    = "tcp"
  from_port   = var.ssh_port
  to_port     = var.ssh_port
  cidr_blocks = [element(var.ssh_allowed_cidrs, count.index)]
}

resource "aws_security_group_rule" "in_icmp" {
  count = var.create ? var.allow_icmp ? 1 : 0 : 0

  security_group_id = aws_security_group.ec2[0].id

  description = "Enables ICMP to the instance"
  type        = "ingress"
  protocol    = "icmp"
  from_port   = "-1"
  to_port     = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Default allow all exiting traffic
resource "aws_security_group_rule" "out_all" {
  count = var.create ? 1 : 0

  security_group_id = aws_security_group.ec2[0].id

  description = "Enables traffic out for the instance"
  type        = "egress"
  protocol    = "-1"
  from_port   = "0"
  to_port     = "0"
  cidr_blocks = ["0.0.0.0/0"]
}

