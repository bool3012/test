#---------------------------------------
# Load Balancer
#---------------------------------------

output "alb_dns_name" {
  value = element(concat(aws_alb.alb.*.dns_name, [""]), 0)
}

output "alb_name" {
  value = element(concat(aws_alb.alb.*.name, [""]), 0)
}

output "alb_zone_id" {
  value = element(concat(aws_alb.alb.*.zone_id, [""]), 0)
}

output "elb_security_group" {
  value = element(concat(aws_security_group.alb.*.id, [""]), 0)
}

output "ec2_security_group" {
  value = element(concat(aws_security_group.ec2.*.id, [""]), 0)
}

output "dns_fqdn" {
  value = element(concat(aws_route53_record.alb.*.fqdn, [""]), 0)
}

output "asg_id" {
  value = element(concat(aws_autoscaling_group.asg.*.id, [""]), 0)
}

output "asg_name" {
  value = element(concat(aws_autoscaling_group.asg.*.name, [""]), 0)
}

output "alb_arns" {
  value = element(concat(aws_alb.alb.*.arn, [""]), 0)
}

output "alb_listener_arn" {
  value = aws_lb_listener.http[0].arn
}