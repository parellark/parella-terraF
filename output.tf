output "SubnetIds" {
    value = module.eks-vpc.public_subnets
}

output "SecurityGroups" {
    value = [aws_security_group.eks-cluster-sg.id]
}

output "VpcId" {
    value = module.eks-vpc.vpc_id
}

output "cluster_iam_role_name" {
  value = module.eks-cluster.cluster_iam_role_name
}

output "node_groups" {
  # value = join("", module.eks-cluster.node_groups.example.resources[0].autoscaling_groups.*.name)
  value = module.eks-cluster.node_groups
}

output "eks_cluster_endpoint" {
  value = module.eks-cluster.cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  value = module.eks-cluster.cluster_certificate_authority_data
}

output "config_map_aws_auth" {
  value = module.eks-cluster.config_map_aws_auth
}
