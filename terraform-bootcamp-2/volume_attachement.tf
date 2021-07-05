resource "aws_volume_attachment" "attach_ebs" {
  volume_id = aws_ebs_volume.ebs.id
  instance_id = aws_instance.ec2.id
  skip_destroy = true
  device_name = "/dev/s${var.device_name}"
}