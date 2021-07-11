resource "aws_route" "anantha_nat_route" {
  route_table_id = aws_vpc.anantha_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.anantha_nat_gateway.id
}