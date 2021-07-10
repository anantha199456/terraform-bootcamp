
  variable "name"{
      default = "anantha-demo"
  }
  
  variable "vpc_zone_identifier" {
      description = "VPC subnets"
  }
  variable "min_size"{
      default = 1
  }
  
  variable "max_size"{
      default = 1
  }

  variable "template_version" {
      default = "$Default"
  }

  variable "launch_template_id" {
      description = "Provide launch tem id to be used in ASD"
  }

  variable "target_group_arns" {
      description = "target_group_arns"
  }
  
  