output "availability_zones" {
  value = data.aws_availability_zones.availability_zones.names
}

output "vpc_id" {
  value = aws_vpc.anantha_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.anantha_private_subnet.*.id
}

output "default_sg_id" {
  value = aws_vpc.anantha_vpc.default_security_group_id
}

output "public_subnet_ids" {
  value = aws_subnet.anantha_public_subnets.*.id
}

output "vpc_cidr_block" {
  value = aws_vpc.anantha_vpc.cidr_block
}