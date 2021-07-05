resource "null_resource" "install_packages" {
for_each = data.aws_subnet_ids.public_subnets.ids
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = var.server_user
      host = aws_instance.anantha_ec2_server[each.value].public_ip
      #host = aws_instance.thinknyx_server[each.value].public_ip
      private_key = file(var.private_key)
    }
    inline = [
      "sudo apt update -y",
      "sudo apt install apache2 -y",
      "sudo service apache2 reload"
    ]
  }
}