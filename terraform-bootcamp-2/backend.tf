terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "tf-bootcamp-2.tf"
    region = "us-east-2"
  }
}