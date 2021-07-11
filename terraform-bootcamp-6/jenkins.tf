module "create_vpc" {
  source = "./modules/create_vpc"
}

module "create_sg_rule" {
  source = "./modules/create_sg_rule"
  security_type = "ingress"
  from_port = "2049"
  to_port = "2049"
  protocol = "TCP"
  cidr_blocks = module.create_vpc.vpc_cidr_block
  sg_id = module.create_vpc.default_sg_id
}

module "create_efs" {
  source = "./modules/efs"
  name = var.name
  subnet_ids = module.create_vpc.private_subnet_ids
  security_groups = module.create_vpc.default_sg_id
}

module "create_load_balancer" {
    source = "./modules/create_lb"
    # subnets = module.create_vpc.anantha_public_subnets
    subnets = module.create_vpc.public_subnet_ids
}

module "create_listner_and_target_group" {
    source = "./modules/create_listener_and_tg"
    port =  "8080"
    protocol =  var.application_port_and_protocol["protocol"]
    load_balancer_arn = module.create_load_balancer.load_balancer_arn
    vpc_id = module.create_vpc.vpc_id
}

module "fetch_ami" {
    source = "./modules/fetch_ami"
}

resource "aws_security_group" "anantha_server_secutity_group" {
  name = "${var.name}_server_terraform"
  description = "Security Group managed by Terraform"
  vpc_id = module.create_vpc.vpc_id
  tags = {
    "Name" = "${var.name}_server_terraform"
  }
  egress  {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "All Open"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } 

  ingress  {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "ssh-port"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = var.application_port_and_protocol["protocol"]
    security_groups = []
    self = false
    to_port = 22
  } 
  ingress {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "application-port"
    from_port =  "8080"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol =  "TCP"
    security_groups = []
    self = false
    to_port =  "8080"
  }  

  ingress {
    cidr_blocks = [ var.all_open_cidr_block ]
    description = "application-port"
    from_port =  var.application_port_and_protocol["port"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol =  var.application_port_and_protocol["protocol"]
    security_groups = []
    self = false
    to_port =  var.application_port_and_protocol["port"]
  }  
}

module "create_launch_template" {
    depends_on = [
        data.template_file.user_data
    ]
    source = "./modules/create_launch_template"
    image_id = module.fetch_ami.ubuntu_20_ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = aws_security_group.anantha_server_secutity_group.id
    user_data = base64encode(data.template_file.user_data.rendered)
}

module "create_auto_scaling_group" {
    source = "./modules/create_asg"
    min_size = 2
    max_size = 2
    launch_template_id = module.create_launch_template.launch_template_id
    target_group_arns = module.create_listner_and_target_group.target_group_arn
    vpc_zone_identifier = module.create_vpc.public_subnet_ids
    
}

resource "null_resource" "get_jenkins_initial_admin_password" {
  depends_on = [
    module.create_auto_scaling_group
  ]
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("d:/anantha-demo.pem")
      host = data.aws_instance.jenkins_server.public_ip
    }
    inline = [
      "sudo cat ${var.JENKINS_HOME}/secrets/initialAdminPassword"
    ]
  }

}