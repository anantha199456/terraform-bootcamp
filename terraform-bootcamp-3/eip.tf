resource "aws_eip" "anantha_nat_eip" {
  tags = {
    Name = "${var.name}_nat"
  }
}