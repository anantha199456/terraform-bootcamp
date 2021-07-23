terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "eks-deploy-bootcamp-7.tf"
    region = "us-east-2"
  }
}