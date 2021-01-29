shared_credentials_file_url="credentials"

#------------network config----------------------------------
VpcName="akshay-----"
VpcBlock="192.168.0.0/16"
Subnet01Block="192.168.64.0/18"
Subnet02Block="192.168.128.0/18"
Subnet03Block="192.168.192.0/18"


#------------cluster config----------------------------------
#version
# Number of Nodes: 4 nodes with 2 core CPU and 7.5GB RAM each ----
# Nodes - Machine configuration:
#                 Machine type: n1-standard-2 (2 vCPU, 7.5 GB memory)
#                 Series: N1
# Nodes Image type: Container-Optimised OS (cos)              
# Boot disk type: Standard persistent disk
# Boot disk size (per node): 100 GB

ClusterName="akshay-eks"

#---------node group config---------------------
ami_type="AL2_x86_64"
disk_size=50
instance_type="t3.medium"

#---------scaling_config---------------------
desired_size=1
max_size=1
min_size=1

#---------Scaling policy configuration-------------
autoscaling_policies_enabled = true

##---------Scale up -----------------
scale_up_cooldown_seconds = 300
scale_up_scaling_adjustment = 1
scale_up_adjustment_type = "ChangeInCapacity"
scale_up_policy_type = "SimpleScaling"

##--------Scale Down ---------------------------
scale_down_cooldown_seconds = 300
scale_down_scaling_adjustment = -1
scale_down_adjustment_type = "ChangeInCapacity"
scale_down_policy_type = "SimpleScaling"


#----------Cloudwatch configuration--------------------
##----------cpu_utilization_high------------------------
cpu_utilization_high_evaluation_periods = 2
cpu_utilization_high_period_seconds = 300
cpu_utilization_high_threshold_percent = 90
cpu_utilization_high_statistic = "Average"

#----------cpu_utilization_low------------------------
cpu_utilization_low_evaluation_periods = 2
cpu_utilization_low_period_seconds = 300
cpu_utilization_low_threshold_percent = 10
cpu_utilization_low_statistic = "Average"
