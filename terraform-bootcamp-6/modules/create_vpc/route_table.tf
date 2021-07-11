resource "aws_route_table" "anantha_routetable" {
  vpc_id = aws_vpc.anantha_vpc.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.anantha_igw.id
  }

  tags = {
    Name = "${var.name}_route_table"
  }
}