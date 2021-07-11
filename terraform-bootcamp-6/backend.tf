terraform {
  backend "s3" {
    bucket = "terraform-state-anantha"
    key = "jenkins-bootcamp-6.tf"
    region = "us-east-2"
  }
}