terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "vpc-resouces-bootcamp-5.tf"
    region = "us-east-2"
  }
}