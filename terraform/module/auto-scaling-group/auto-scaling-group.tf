resource "aws_autoscaling_group" "self" {
  name                      = "${var.name}-${var.env}"
  max_size                  = var.asg_capacity_max
  min_size                  = var.asg_capacity_min
  desired_capacity          = var.asg_capacity_desired
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = var.force_delete
  service_linked_role_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  target_group_arns         = var.target_group_arns
  vpc_zone_identifier       = data.aws_subnet_ids.private.ids

  launch_template {
    id      = aws_launch_template.self.id
    version = var.lt_version
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-${var.env}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "10m"
  }

}

resource "aws_autoscaling_schedule" "self" {
  for_each = var.scheduled_actions

  scheduled_action_name  = each.value.name
  min_size               = each.value.min_size
  max_size               = each.value.max_size
  desired_capacity       = each.value.desired_size
  recurrence             = each.value.recurrence
  autoscaling_group_name = aws_autoscaling_group.self.name
}
