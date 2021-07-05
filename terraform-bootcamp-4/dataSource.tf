data "aws_vpc" "vpc" {
  filter {
    name = "tag:Name"
    values = [ var.name ]
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:Type"
    values = [ "public" ]
  }
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name = "tag:Type"
    values = [ "private" ]
  }
}