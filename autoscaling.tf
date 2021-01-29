resource "aws_autoscaling_policy" "scale_up" {
  count                  = var.autoscaling_policies_enabled ? 1 : 0
  name                   = "${var.ClusterName}_scale_up"
  autoscaling_group_name = join("", module.eks-cluster.node_groups.example.resources[0].autoscaling_groups.*.name)
  adjustment_type        = var.scale_up_adjustment_type
  policy_type            = var.scale_up_policy_type
  cooldown               = var.scale_up_cooldown_seconds
  scaling_adjustment     = var.scale_up_scaling_adjustment
  
  depends_on = [
    module.eks-cluster
  ]
}

resource "aws_autoscaling_policy" "scale_down" {
  count                  = var.autoscaling_policies_enabled ? 1 : 0
  name                   = "${var.ClusterName}_scale_down"
  autoscaling_group_name = join("", module.eks-cluster.node_groups.example.resources[0].autoscaling_groups.*.name)
  adjustment_type        = var.scale_down_adjustment_type
  policy_type            = var.scale_down_policy_type
  cooldown               = var.scale_down_cooldown_seconds
  scaling_adjustment     = var.scale_down_scaling_adjustment
  
  depends_on = [
    module.eks-cluster
  ]
  
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count                  = var.autoscaling_policies_enabled ? 1 : 0
  alarm_name          = "${var.ClusterName}_cpu_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_utilization_high_evaluation_periods
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period              = var.cpu_utilization_high_period_seconds
  statistic           = var.cpu_utilization_high_statistic
  threshold           = var.cpu_utilization_high_threshold_percent

  dimensions = {
    AutoScalingGroupName = join("", module.eks-cluster.node_groups.example.resources[0].autoscaling_groups.*.name)
  }

  alarm_description = "Scale up if CPU utilization is above 80 for 120 seconds"
  alarm_actions     = [join("", aws_autoscaling_policy.scale_up.*.arn)]

  depends_on = [
    aws_autoscaling_policy.scale_up,
    module.eks-cluster
  ]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count                  = var.autoscaling_policies_enabled ? 1 : 0
  alarm_name                = "${var.ClusterName}_cpu_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_utilization_low_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.cpu_utilization_low_period_seconds
  statistic           = var.cpu_utilization_low_statistic
  threshold           = var.cpu_utilization_low_threshold_percent

  dimensions = {
    AutoScalingGroupName = join("", module.eks-cluster.node_groups.example.resources[0].autoscaling_groups.*.name)
  }

  alarm_description = "Scale down if the CPU utilization is below 80 for 120 seconds"
  alarm_actions     = [join("", aws_autoscaling_policy.scale_down.*.arn)]

  depends_on = [
    aws_autoscaling_policy.scale_down,
    module.eks-cluster
  ]
}
