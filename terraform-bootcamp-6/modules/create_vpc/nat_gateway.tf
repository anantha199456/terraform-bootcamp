resource "aws_nat_gateway" "anantha_nat_gateway" {
  allocation_id = aws_eip.anantha_nat_eip.id
  subnet_id     = aws_subnet.anantha_public_subnets[0].id

  tags = {
    Name = var.name
  }

}