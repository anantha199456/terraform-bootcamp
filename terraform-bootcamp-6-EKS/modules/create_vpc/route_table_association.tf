resource "aws_route_table_association" "anatha_igw_public_subnets" {
  subnet_id = aws_subnet.anantha_public_subnets[count.index].id
  route_table_id = aws_route_table.anantha_routetable.id
  count = length(data.aws_availability_zones.availability_zones.names)
}