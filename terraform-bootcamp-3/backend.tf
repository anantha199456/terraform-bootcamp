terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "vpc-bootcamp-3.tf"
    region = "us-east-2"
  }
}