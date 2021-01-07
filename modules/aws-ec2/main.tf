# main.tf

# Define some shortcuts to be used along the module
locals {
  env  = upper(var.tags["Environment"])
  name = upper(var.name)
  prefix = upper(
    format("%s-%s-%s", var.tags["ApplicationName"], local.env, var.name),
  )
}

# EC2 instances
resource "aws_instance" "instance" {
  count = var.create ? 1 : 0

  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, count.index)
  associate_public_ip_address = var.public ? true : false
  key_name                    = var.ssh_key
  user_data                   = var.user_data
  monitoring                  = var.enable_monitoring
  private_ip                  = length(var.private_ips) > 0 ? element(concat(var.private_ips, [""]), count.index) : ""

  source_dest_check = false

  # root block device
  root_block_device {
    volume_type = var.root_vol_type
    volume_size = var.root_vol_size
  }

  volume_tags = merge(
    var.tags,
    {
      "Name" = format("%s-%02d-EBS", local.prefix, count.index + 1)
    },
    {
      "ResourceName" = format("%s-%02d-EBS", local.prefix, count.index + 1)
    },
    {
      "ResourceType" = "EBS"
    },
    {
      "ApplicationName" = "CWS"
    },
  )

  # security
  vpc_security_group_ids = concat([aws_security_group.ec2[0].id], flatten(var.security_groups))
  iam_instance_profile   = var.iam_instance_profile

  tags = merge(
    var.tags,
    {
      "Name" = format("%s-%02d-EC2", local.prefix, count.index + 1)
    },
    {
      "ResourceName" = format("%s-%02d-EC2", local.prefix, count.index + 1)
    },
    {
      "ResourceType" = "EC2"
    },
    {
      "ApplicationName" = "CWS"
    },
  )
}

# Register instance into DNS
resource "aws_route53_record" "instance" {
  count = var.create ? var.register_dns ? 1 : 0 : 0

  zone_id = var.dns_zone
  name    = format("%s-%s.%s", var.hostname_prefix, local.env, var.domain_name)
  type    = "A"
  ttl     = var.dns_ttl
  records = [element(aws_instance.instance.*.private_ip, count.index)]
}

