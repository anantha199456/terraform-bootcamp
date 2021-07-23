  
# Creating DynamoDB Table
resource "aws_dynamodb_table" "users" {
  name = "users"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5
  hash_key = var.hash_key
  attribute {
    name = "email"
    type = "S"
  }
  tags = {
    Name = var.name
  }
}

# Creating Role for EC2
module "create_iam_cluster_role" {
  source = "./modules/create_iam_role"
  role_name = var.role["name"]
  service = var.role["service"]
}

# Create Instance Profile for Role
resource "aws_iam_instance_profile" "dynamodb" {
  name = var.name
  role = module.create_iam_cluster_role.role_name
}

# Adding Policy to Role
module "attached_iam_policy_with_cluster_role" {
  source = "./modules/attach_iam_policy_with_iam_role"
  role_name = module.create_iam_cluster_role.role_name
  policy_name = "AmazonDynamoDBFullAccess"
}

data "aws_region" "current_region" {}

resource "aws_instance" "dynamodb_app" {
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name = "anantha-demo"
  iam_instance_profile = aws_iam_instance_profile.dynamodb.name
  tags = {
    "Name" = var.name
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = file("D:/anantha-demo.pem")
    }
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y python3 python3-pip git nodejs npm",
      "sudo npm install forever -g",
      "git clone https://github.com/kul-samples/sample_python_dynamodb.git",
      "cd sample_python_dynamodb/",
      "pip3 install -r requirements.txt",
      "export REGION_NAME=${data.aws_region.current_region.name}",
      "export PORT_NUMBER=4000",
      "forever start -c python3 app.py"
    ]
  }
}