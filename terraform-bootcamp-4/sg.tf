resource "aws_security_group" "anantha_server_secutity_group" {
  name = "${var.sg_name}_server_terraform"
  description = "Security Group managed by Terraform"
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    "Name" = "${var.sg_name}_server_terraform"
  }
  egress = [ {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "All Open"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } ]
  ingress = [ {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "ssh-port"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "TCP"
    security_groups = []
    self = false
    to_port = 22
  } ]
}