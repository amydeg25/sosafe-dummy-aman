# Specify the backend as S3 for storing the Terraform state
terraform {
  backend "s3" {
    bucket = "aman-final"
    key    = "eks-terra/terraform.tfstate"
    region = "eu-central-1"
  }
}

