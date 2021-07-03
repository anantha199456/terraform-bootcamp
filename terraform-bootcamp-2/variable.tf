variable "name"{
  default = "kul"
}
variable "ami"{
  default = "ami-00399ec92321828f5"
}
variable "instance_type"{
  default = "t2.micro"
}
variable "key_name"{
  default = "kul"
}
variable "ebs_size" {
  default = 1
}
variable "device_name" {
  default = "df"
}