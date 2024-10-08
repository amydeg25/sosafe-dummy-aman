# EKS Module Configuration
module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "19.15.1" # Update to 20.24.2 if deprecation warnings
  cluster_name                   = var.cluster_name
  cluster_endpoint_public_access = true
  cluster_version                = var.kubernetes_version

  enable_irsa = true # Enable IAM Roles for Service Accounts (IRSA)

  # Addon Plugins Configuration 
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id          # VPC ID where the cluster is deployed
  subnet_ids               = module.vpc.private_subnets # Subnet IDs for the EKS cluster
  control_plane_subnet_ids = module.vpc.intra_subnets   # Subnets for the control plane

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["m5.large"]

    attach_cluster_primary_security_group = true

  }
  # Security Group Tags for Nodes
  node_security_group_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = null # Tag for cluster identification
  }

  # EKS Managed Node Groups Configuration
  eks_managed_node_groups = {
    aman-final-ng = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.large"]
      capacity_type  = "SPOT" # Used this for Cost efficiency
    }
  }

  tags = local.tags # Tags to apply to all resources
}

# Update Kubeconfig for Authentication
resource "null_resource" "update_kubeconfig" {
  depends_on = [module.eks] # Ensure EKS Module is created first

  # Execute commands on the local machine to configure kubeconfig
  provisioner "local-exec" {
    command = <<EOF
    rm -f ~/.kube/config
    aws eks update-kubeconfig --name ${var.cluster_name} --region ${local.region}
    export KUBERNETES_MASTER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
    export KUBECONFIG=~/.kube/config
  EOF
  }
}
