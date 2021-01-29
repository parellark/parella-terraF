data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "eks-cluster-sg" {
  name        = "eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = module.eks-vpc.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

module "eks-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VpcName
  cidr = var.VpcBlock
  enable_dns_support = true
  enable_dns_hostnames = true

  create_igw = true
  igw_tags = {
    Name = "${var.VpcName}_igw"
  }

  public_route_table_tags  = {
    Name: "Public Subnets"
    Network: "Public"
  }

  azs             = data.aws_availability_zones.available.names
  public_subnets  = (length(data.aws_availability_zones.available.names) > 2 ? [var.Subnet01Block, var.Subnet02Block, var.Subnet03Block] : [var.Subnet01Block, var.Subnet02Block])
  public_subnet_tags = {
      # "kubernetes.io/cluster/${var.ClusterName}" = "shared"
      "kubernetes.io/role/elb" = 1
  }

  tags = {
    "kubernetes.io/cluster/${var.ClusterName}" = "shared"
    Terraform = "true"
    Environment = "dev"
  }
}
