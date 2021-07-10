resource "aws_launch_template" "launch_template"{
    name = var.name
    image_id = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids  = [var.vpc_security_group_ids]
    user_data = var.user_data
    tag_specifications {
        resource_type = "instance"

        tags = {
        Name = var.name
        }
    }
    tag_specifications {
        resource_type = "volume"

        tags = {
        Name = var.name
        }
    }
    tags = {
      Name = var.name
    }
    update_default_version = true
}