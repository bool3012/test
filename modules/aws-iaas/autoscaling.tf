/*
    Autoscaling

    Defines an autoscaling group for EC2 instances that will use the defined Launch configuration.
    An HTTP target group for registering instances will be created by the module, but you can attach
    additional target groups (for example if using multiple load balancers in front of your instances)
    using module variables.
*/

resource "aws_autoscaling_policy" "module_scaling_policy" {
  count = var.create ? 1 : 0
  
  name                   = format("CWS-%s-%s-ASP", local.env, local.name)
  policy_type            = "TargetTrackingScaling"
  #adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg[0].name

  target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.scaling_avg_cpu_value
    }
}

# Deploy launch configuration
resource "aws_launch_configuration" "lc" {
  count = var.create ? 1 : 0

  name_prefix                 = format("LC-%s-", local.name)
  image_id                    = var.image_id
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  security_groups             = concat([aws_security_group.ec2[0].id], flatten(var.ec2_security_groups))
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  enable_monitoring           = var.enable_monitoring
  ebs_optimized               = var.ebs_optimized
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      no_device             = lookup(ebs_block_device.value, "no_device", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
    }
  }
  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      device_name  = ephemeral_block_device.value.device_name
      virtual_name = ephemeral_block_device.value.virtual_name
    }
  }
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Deploys the autoscaling group

# resource "aws_autoscaling_attachment" "asg_attach_module_iaas" {
#   autoscaling_group_name = "${element(concat(aws_autoscaling_group.asg.*.id, list("")), 0)}"
#   alb_target_group_arn   = "${element(concat(aws_alb_target_group.http.*.arn, list("")), 0)}"
# }

# output "bla" {
#     value = "${concat(aws_autoscaling_group.asg.*.id, list(""))}"
# }

resource "aws_autoscaling_group" "asg" {
  count = var.create ? 1 : 0

  name = format(
    "%s-%s-%s",
    local.prefix,
    local.name,
    aws_launch_configuration.lc[0].name,
  )
  launch_configuration = element(concat(aws_launch_configuration.lc.*.name, [""]), 0)
  vpc_zone_identifier  = var.ec2_subnets

  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity

  # Health check for autoscaling
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type

  # ELB capacity
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  default_cooldown          = var.default_cooldown
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  # Define target groups to register instances into.
  # This is set to module's target group plus additional TGs passed as variable.

  target_group_arns = compact(
    concat(
      aws_alb_target_group.http.*.arn,
      var.additional_target_groups,
      [""],
    ),
  )

  force_delete          = var.force_delete
  enabled_metrics       = var.enabled_metrics
  metrics_granularity   = var.metrics_granularity
  protect_from_scale_in = var.protect_from_scale_in

  depends_on = [aws_launch_configuration.lc]

  lifecycle {
    create_before_destroy = true
  }

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  tag {
    key                 = "Name"
    value               = format("%s-%s-%s-EC2", var.tags_as_map["ApplicationName"], local.env, local.name)
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags_as_map

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
