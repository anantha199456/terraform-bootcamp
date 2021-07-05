terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "vpc-resouces-bootcamp-4.tf"
    region = "us-east-2"
  }
}