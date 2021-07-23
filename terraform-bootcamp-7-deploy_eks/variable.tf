variable "name" {
  default = "anantha-tomcat"
}

variable "image" {
  default = "kulbhushanmayer/tomcat:8.5.61"
}

variable "service_type" {
  default = "LoadBalancer"
}