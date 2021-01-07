variable "create" {
  description = "(Optional) Set to false to avoid creation of resources in this module."
  default     = "true"
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "elb_subnets" {
  type = list(string)
}

variable "public" {
  description = "(Optional) Creates a public load balancer"
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  default = true
}

variable "elb_security_groups" {
  description = "A list of security group IDs to assign to the load balancer."
  default     = []
}

variable "ec2_security_groups" {
  description = "A list of security group IDs to assign to the launched instances."
  default     = []
}

variable "ssh_source_restriction" {
  description = "(Reccomended) Specify a security group id allowed to connect via SSH to instances."
  default     = ""
}

## ALB HEALTHCHECK

variable "health_check_interval" {
  description = "(Optional) The interval for Application Load Balancer health checks"
  default     = "30"
}

variable "health_check_path" {
  description = "(Optional) The path to be used for Application Load Balancer health checks"
  default     = "/"
}

variable "health_check_timeout" {
  description = "(Optional) Fails health check after this amount of time without response"
  default     = "5"
}

variable "health_check_healthy" {
  description = "(Optional) The minimum number of successfull checks to consider instance healthy"
  default     = "5"
}

variable "health_check_unhealthy" {
  description = "(Optional) The minimum number of successfull checks to consider instance unhealthy"
  default     = "3"
}

variable "stickiness_enable" {
  default = false
}

variable "cookie_duration" {
  default = "86400"
}

## DNS ##

variable "register_dns" {
  description = "(Optional) Set to true to enable Route53 resources registration."
  default     = false
}

variable "domain_zone_id" {
  description = "(Required) The ID of the Route53 zone to register resources in."
  default     = ""
}

variable "domain_name" {
  description = "(Required) The name of the domain to register resources in."
  default     = ""
}

## Logging ##

variable "disable_logging" {
  default = false
}

variable "elb_log_bucket" {
  type = string
}

variable "elb_log_prefix" {
  default = ""
}

## SSL ##

variable "ssl_cert_arn" {
  description = "(Optional) The ARN of the SSL certificate to use with the Load Balancer."
  default     = ""
}

variable "elb_stockex_certificate_arn" {
  description = "(Optional) Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager"
  default     = ""
}
## EC2 ##

variable "image_id" {
  type        = string
  description = "(Required) The ID of the AMI image to use for creating the instance."
}

variable "instance_type" {
  type = string
}

variable "iam_instance_profile" {
  description = "(Optional) The IAM instance profile to associate with launched instances."
  default     = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  default     = false
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = " "
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = true
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(string)
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = list(string)
  default     = []
}

## AUTOSCALING ##

variable "max_size" {
  description = "The maximum size of the auto scale group"
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "ec2_subnets" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
}

variable "health_check_protocol" {
  default = ""
}

variable "health_check_port" {
  default = ""
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  default     = []
}

variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  default     = 0
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

/* LSEAW-3173: Added to allow specifying additional target groups to the autoscaling. */
variable "additional_target_groups" {
  description = "(Optional) Associate additional target groups to the autoscaling group. This will allow you to have multiple load balancers in front of your instances."
  default     = []
}

variable "additional_cidrs_out" {
  description = "(Optional) Specify additional CIDR addresses to allow in egress rules for instances security group"
  default     = []
}

## AUTOSCALING POLICY ##
variable "scaling_policy_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "scaling_policy_adjustment" {
  description = "The number of instances to add during autoscaling"
  default     = 1
}

variable "scaling_avg_cpu_value" {
  description = "The avg cpu value to scale up"
  default     = 70.0
}
