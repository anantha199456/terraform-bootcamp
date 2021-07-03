  
resource "aws_ebs_volume" "ebs"{
  size = var.ebs_size
  availability_zone = aws_instance.ec2.availability_zone
  tags = {
    Name = var.name
  }
}