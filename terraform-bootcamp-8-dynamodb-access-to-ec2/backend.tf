terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "dynamodb-ec2-access-08.tf"
    region = "us-east-2"
  }
}