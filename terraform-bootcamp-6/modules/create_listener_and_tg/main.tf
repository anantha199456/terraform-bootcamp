resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.name}-${var.port}"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  target_type = "instance"
  tags = {
      "Name" = var.name
  }
}
