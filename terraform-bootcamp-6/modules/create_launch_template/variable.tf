variable "name" {
    default = "anantha-demo"
}
variable "image_id" {
    description = "Provide AMI ID"
}
variable "vpc_security_group_ids" {
    default = "default"
}
variable "instance_type" {
    default = "t2.nano"
}
variable "key_name" {
    default = "anantha-demo"
  }
variable "user_data" {
    description = "PRovide the user_data"
}

variable "git_repo" {
    default =  "https://github.com/kul-samples/sample-nodejs-postgres.git"
}
