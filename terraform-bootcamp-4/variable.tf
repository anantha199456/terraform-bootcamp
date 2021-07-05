variable "ami" {
  default = "ami-00399ec92321828f5"
}

variable "region_name" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "name" {
    default = "terraform_default"
}

variable "sg_name" {
  default = "anantha"
}

variable "all_open_cidr_block" {
  default = "0.0.0.0/0"
}

variable "server_user" {
  default = "ubuntu"
}

variable "private_key" {
  default = "D:/anantha-demo.pem"
}