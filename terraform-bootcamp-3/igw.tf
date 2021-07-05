resource "aws_internet_gateway" "anantha_igw" {
  tags = {
    "Name" = var.name
  }
  vpc_id = aws_vpc.anantha_vpc.id
}