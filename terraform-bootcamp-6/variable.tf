
variable "name" {
  default = "anantha-demo"
}

# variable "name_ec2" {
#   default = "anantha-demo"
# }


variable "region_name" {
  default = "us-east-2"
}

variable "all_open_cidr_block" {
  default = "0.0.0.0/0"
}

variable "application_port_and_protocol" {
  type = map 
  default = {
    port = 4000
    protocol = "TCP"
  }
}

variable "Jenkins_port_protocol" {
  type = map 
  default = {
    port = 8080
    protocol = "TCP"
  }
}

variable "jenkins_version" {
  default = "2.301"
}
variable "application_port" {
  type = map
  default = {
    port = 8080
    protocol = "TCP"
    cidr_blocks = "0.0.0.0/0"
  }
}
variable "ssh_port" {
  type = map
  default = {
    port = 22
    protocol = "TCP"
    cidr_blocks = "0.0.0.0/0"
  }
}
variable "JENKINS_HOME" {
  default = "/JENKINS_HOME"
}