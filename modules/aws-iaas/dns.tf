# dns.tf ~ Registers resources in Route53 domain

# Create A-type alias record for the load balancer
resource "aws_route53_record" "alb" {
  count = var.create && var.register_dns ? 1 : 0 # Conditional creation

  zone_id = var.domain_zone_id
  name    = format("%s-%s.%s", lower(var.name), lower(local.env), lower(var.domain_name))
  type    = "A"

  alias {
    name                   = aws_alb.alb[0].dns_name
    zone_id                = aws_alb.alb[0].zone_id
    evaluate_target_health = "false"
  }
}

