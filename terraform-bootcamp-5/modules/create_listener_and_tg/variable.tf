variable "port" {
    description = "port for the listerner"
}

variable "protocol" {
    description = "protocol for the listerner"
}

variable "load_balancer_arn" {
    description = "load_balancer_arn for the listerner"
}

variable "name" {
    default = "anantha-demo"
}

variable "vpc_id" {
    description = "vpc_id for the TG"
}
