data "aws_availability_zones" "availability_zones"{
  state = "available"
}

resource "aws_autoscaling_group" "aws_autoscaling_group" {
#   availability_zones = data.aws_availability_zones.availability_zones.names
  desired_capacity   = var.min_size
  max_size           = var.max_size
  min_size           = var.min_size
  vpc_zone_identifier = var.vpc_zone_identifier

  launch_template {
    id      = var.launch_template_id
    version = var.template_version
  }
  target_group_arns = [ var.target_group_arns ]
    health_check_type = "ELB"
    tags = [ {
        "Name" = var.name
    } ]
}