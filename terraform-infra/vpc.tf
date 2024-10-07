# VPC module for creating VPC and subnet resources
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  # VPC configuration details
  name = var.cluster_name
  cidr = local.vpc_cidr

  # Subnet and availability zone configurations
  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnets

  # Enabling NAT Gateway
  enable_nat_gateway = true

  # Tagging public subnets for external load balancers
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  # Tagging private subnets for internal load balancers
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}