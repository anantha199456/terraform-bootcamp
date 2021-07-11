
variable "name" {
  default = "anantha-demo"
}

variable "subnet_ids" {
  description = "the listo f subnets"
}
variable "security_groups" {
  description = "internal NFSSH for interal communication"
}