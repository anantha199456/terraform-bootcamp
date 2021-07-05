resource "aws_instance" "anantha_ec2_server" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = "anantha-demo"
  for_each = data.aws_subnet_ids.public_subnets.ids
  subnet_id = each.value
  vpc_security_group_ids = [ aws_security_group.anantha_server_secutity_group.id ]
  tags = {
    "Name" = "anantha_${var.name}"
  }
  # provisioner "file" {
  #   source      = "script.sh"
  #   destination = "/tmp/script.sh"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/script.sh",
  #     "/tmp/script.sh args",
  #   ]
  # }
}