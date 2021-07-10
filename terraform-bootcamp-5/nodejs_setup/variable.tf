variable "region_name" {
  default = "us-east-2"
}
variable "db_name" {
  default = "postgres"
}

variable "all_open_cidr_block" {
  default = "0.0.0.0/0"
}

variable "name" {
    default = "terraform_anantha"
}

# variable "module_loc" {
#   default = "../modules"
# }
variable "git_repo" {
    default =  "https://github.com/kul-samples/sample-nodejs-postgres.git"
}

variable "application_port_and_protocol" {
  type = map 
  default = {
    port = 4000
    protocol = "TCP"
  }
}

variable "rds_port_and_protocol" {
  type = map 
  default = {
    port = 5432
    protocol = "TCP"
  }
}