data "aws_instance" "jenkins_server" {
  filter {
    name = "tag:aws:ec2launchtemplate:id"
    values = [ module.create_launch_template.launch_template_id ]
  }
  filter {
    name = "tag:aws:autoscaling:groupName"
    values = [ var.name ]
  }
}