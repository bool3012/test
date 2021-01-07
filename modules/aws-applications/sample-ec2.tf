# zipkin.tf - Deploys ZIPKIN host

data "template_file" "zipkin_init" {
  template = file("../tf-applications/templates/init.zipkin.tpl")

  vars = {
    CWS_ENV         = local.env
    proxy_ip        = var.private_ips["proxy"]
    proxy_port      = "3128"
    deploy_bucket   = var.deploy_bucket
    DD_URL          = var.dd_url
  }
}


module "zipkin" {
  source = "../tf-modules/lse-aws-ec2"

  create = "true"

  name = "zipkin"

  ami           = var.ami["rh-tomcat"]
  instance_type = var.zipkin_instance_config["instance_type"]
  ssh_key       = var.ssh_keys["mgmt"]
  user_data     = data.template_file.zipkin_init.rendered
  public        = false

  # This will enable detailed monitoring
  enable_monitoring = false


  # Networking
  vpc_id     = var.vpc_id
  subnet_ids =flatten(var.web_subnets)
  allow_icmp = true

  # Security Groups for management
  ssh_source_restriction = aws_security_group.ssh_management.id
  security_groups = [var.cet_app_tier_sg_id]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id

  # DNS
  register_dns    = true
  hostname_prefix = "zipkin"
  domain_name     = data.aws_route53_zone.local.name
  dns_zone        = data.aws_route53_zone.local.zone_id

  tags = merge(
    var.common_tags,
    {
      "Role" = "zipkin"
    },
    {
      "VPCID" = var.vpc_id
    }
  )
}



#------------------------------------------------------------
#  SECURITY GROUPS
#------------------------------------------------------------

resource "aws_security_group_rule" "zipkin_ec2_in_api_aggregator" {
  
  security_group_id        = module.zipkin.ec2_security_group
  description              = "Allow HTTP traffic from API Aggregator"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 9411
  to_port                  = 9411
  source_security_group_id = module.apiaggregator.ec2_security_group
}
