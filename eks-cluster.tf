module "eks-cluster" {
  source       = "terraform-aws-modules/eks/aws"
  cluster_name = var.ClusterName
  cluster_version = "1.17"
  
  cluster_enabled_log_types = [
	  "api",
	  "audit",
	  "authenticator",
	  "controllerManager",
	  "scheduler",
	]
	cluster_log_retention_in_days = 1 # Number of days to retain log events. Default retention - 90 days.


  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  #Networking config
  vpc_id = module.eks-vpc.vpc_id
  subnets      = module.eks-vpc.public_subnets

    node_groups_defaults = {
      ami_type  = var.ami_type #"AL2_x86_64"
      disk_size = var.disk_size #50
    }
    
    node_groups = {
      example = {
        desired_capacity = var.desired_size
        max_capacity     = var.max_size
        min_capacity     = var.min_size

        instance_type = var.instance_type #"t2.small"
        k8s_labels = {
          Environment = "test"
          GithubRepo  = "terraform-aws-eks"
          GithubOrg   = "terraform-aws-modules"
        }
        additional_tags = {
          ExtraTag = "example"
        }
      }
    }

  manage_aws_auth = false # this will write config file for cubectl
  
  # this will write config file for cubectl
  # required AWS CLI
  # for windows
  #manage_aws_auth = true 
  #kubeconfig_aws_authenticator_command = "aws"
  # config_output_path = "~/.kube/config"
  # wait_for_cluster_interpreter = ["C:\\Users\\c-akshaycha\\AppData\\Local\\Programs\\Git\\bin\\sh.exe", "-c"]
  # wait_for_cluster_cmd         = "until curl -sk $ENDPOINT >/dev/null; do sleep 4; done"
}
