resource "aws_instance" "ubuntu_server" {
  for_each = toset(data.aws_availability_zones.availability_zones.names)
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name = "kul"
  tags = {
    "Name" = "kul"
  }
  availability_zone = each.value
}