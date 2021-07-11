resource "aws_lb" "load_balancer" {
  name               = var.name 
  internal           = false
  load_balancer_type = var.lb_type
#   security_groups    = [var.sg_name]
  subnets            = var.subnets

  tags = {
    Name = var.name
  }
}