variable "name" {
    default = "anantha-demo"
}
variable "subnet_ids" {
    description = "subnet_ids"
}
variable "engine_version" {
    default = "12.3"
}
variable "allocated_storage" {
    default = "10"
}
variable "storage_type" {
    default = "gp2"
}
variable "instance_class" {
    default = "db.t2.micro"
}
variable "port" {
    default = "5432"
}

variable "vpc_sg_id" {
    description = "subnet_ids"
}

variable "db_name" {
    default = "postgres"
}

variable "db_user" {
    default = "postgres"
}

variable "db_password" {
    # default = "postgres"
}



