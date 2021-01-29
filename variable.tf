#variable "shared_credentials_file_url" {
#    type = string
#    default = "credentials"
#    description = "Enter valid credentials file url."
#}
variable "access_key" {
    type = string
    #default = "credentials"
    description = "Enter valid access key."
}
variable "secret_key" {
    type = string
    #default = "credentials"
    description = "Enter valid secret key."
}

#------------network config----------------------------------
variable "VpcName" {
    type = string
    default = "akshay-----"
    description = "Enter valid name for your VPC."
}

variable "VpcBlock" {
    type = string
    default = "192.168.0.0/16"
    description = "Choose a CIDR range for your VPC. You can keep the default value."
}

variable "Subnet01Block" {
    type = string
    default = "192.168.64.0/18"
    description = "Specify a CIDR range for public subnet 1. We recommend that you keep the default value so that you have plenty of IP addresses for load balancers to use."
}

variable "Subnet02Block" {
    type = string
    default = "192.168.128.0/18"
    description = "Specify a CIDR range for public subnet 2. We recommend that you keep the default value so that you have plenty of IP addresses for load balancers to use."
}

variable "Subnet03Block" {
    type = string
    default = "192.168.192.0/18"
    description = "Specify a CIDR range for private subnet 1. We recommend that you keep the default value so that you have plenty of IP addresses for pods and load balancers to use."
}

#------------cluster config----------------------------------
variable "ClusterName" {
    type = string
    default = "akshay-eks"
    description = "Enter valid name for your EKS cluster."
}

#---------node group config---------------------
variable "ami_type" {
    type = string
    default = "AL2_x86_64"
    description = "(Optional) Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
    #experimental
    # validation {
    #     condition     = contains(["AL2_x86_64", "AL2_x86_64_GPU"], var.ami_type)
    #     error_message = "Valid values: AL2_x86_64, AL2_x86_64_GPU."
    # }
}

variable "disk_size" {
    type = number
    default = 50
    description = "(Optional) Disk size in GiB for worker nodes. Defaults to 20."
}

variable "instance_type" {
    type = string
    default = "t2.small"
    description = "(Optional) Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]"
}


#---------scaling_config---------------------
variable "desired_size" {
    type = number
    default = 1
    description = "(Required) Desired number of worker nodes."
}

variable "max_size" {
    type = number
    default = 1
    description = "(Required) Maximum number of worker nodes."
}

variable "min_size" {
    type = number
    default = 1
    description = "(Required) Minimum number of worker nodes."
}

#---------Scaling policy configuration-------------
variable "autoscaling_policies_enabled" {
  type        = bool
  default     = true
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

##---------Scale up -----------------
variable "scale_up_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  type        = number
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

##--------Scale Down ---------------------------
variable "scale_down_cooldown_seconds" {
  type        = number
  default     = 300
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  type        = number
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = string
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = string
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}


#----------Cloudwatch configuration--------------------
##----------cpu_utilization_high------------------------
variable "cpu_utilization_high_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = number
  default     = 90
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

#----------cpu_utilization_low------------------------
variable "cpu_utilization_low_evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = number
  default     = 300
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = number
  default     = 10
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}
