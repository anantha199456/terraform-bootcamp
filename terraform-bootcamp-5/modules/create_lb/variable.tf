
variable "name" {
    default = "anantha-demo"
}
variable "lb_type" {
    default = "network"
}
variable "subnets" {
    description = "Provide pubic subnet IDs"
}

# variable "sg_name" {
#     description = "Provide pubic subnet IDs"
# }