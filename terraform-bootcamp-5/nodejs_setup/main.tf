# you can't hardcode the variable value here.
module "create_vpc" {
    source = "../modules/create_vpc"
}

module "fetch_ami" {
    source = "../modules/fetch_ami"
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
    from_port =  var.application_port_and_protocol["port"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol =  var.application_port_and_protocol["protocol"]
    security_groups = []
    self = false
    to_port =  var.application_port_and_protocol["port"]
  } 

    ingress {
    cidr_blocks = [ module.create_vpc.vpc_cidr_block]
    description = "RDS-port"
    from_port =  var.rds_port_and_protocol["port"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol =  var.rds_port_and_protocol["protocol"]
    security_groups = []
    self = false
    to_port =  var.rds_port_and_protocol["port"]
  } 
}

# data "template_file" "user_data" {
#   template = "${file("${path.module}/init.tpl")}"
# }
data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash -xe
sudo apt-get update -y
sudo apt-get install -y nodejs npm postgresql-client
sudo npm install -g forever
git clone ${var.git_repo} /opt/app
cd /opt/app
npm install
export PGPASSWORD=postgres
export DB_USER=${module.create_post_rds.username}
export DB_PWD=postgres
export DB_URL=${module.create_post_rds.address}
psql -h $DB_URL -U $DB_USER --dbname ${var.db_name} < createEmployeeTable.sql
forever start app.js
  EOF
}

module "create_launch_template" {
    depends_on = [
        data.template_file.user_data
    ]
    source = "../modules/create_launch_template"
    image_id = module.fetch_ami.ubuntu_20_ami_id
    instance_type = "t2.micro"
    vpc_security_group_ids = aws_security_group.anantha_server_secutity_group.id
    user_data = base64encode(data.template_file.user_data.rendered)
}

module "create_load_balancer" {
    source = "../modules/create_lb"
    # subnets = module.create_vpc.anantha_public_subnets
    subnets = module.create_vpc.public_subnet_ids
}

module "create_listner_and_target_group" {
    source = "../modules/create_listener_and_tg"
    port =  var.application_port_and_protocol["port"]
    protocol =  var.application_port_and_protocol["protocol"]
    load_balancer_arn = module.create_load_balancer.load_balancer_arn
    vpc_id = module.create_vpc.vpc_id
}

module "create_auto_scaling_group" {
    source = "../modules/create_asg"
    min_size = 2
    max_size = 5
    launch_template_id = module.create_launch_template.launch_template_id
    target_group_arns = module.create_listner_and_target_group.target_group_arn
    vpc_zone_identifier = module.create_vpc.public_subnet_ids
    
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

module "create_post_rds" {
    # for_each      = data.aws_subnet_ids.example.ids
    source = "../modules/create_postgres_rds"
    # db_password = random_password.password.result
    db_password = "postgres"
    subnet_ids = tolist(module.create_vpc.private_subnet_ids)
    vpc_sg_id = aws_security_group.anantha_server_secutity_group.id
}