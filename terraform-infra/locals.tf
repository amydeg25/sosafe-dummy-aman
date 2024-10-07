# Local variables for region, VPC configuration, and tags
locals {
  region = "eu-central-1"

  # VPC and subnet CIDR configurations
  vpc_cidr = "10.120.0.0/16"
  azs      = ["eu-central-1a", "eu-central-1b"]

  # Subnets for public, private, and intra-communication
  public_subnets  = ["10.120.1.0/24", "10.120.2.0/24"]
  private_subnets = ["10.120.3.0/24", "10.120.4.0/24"]
  intra_subnets   = ["10.120.5.0/24", "10.120.6.0/24"]

  # Tags for resources
  tags = {
    Example = var.cluster_name
  }
}



