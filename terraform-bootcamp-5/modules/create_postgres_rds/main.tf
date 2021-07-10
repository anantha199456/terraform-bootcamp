# Provision AWS PostgreSQL Database
resource "aws_db_instance" "postgres_db" {
  identifier             = var.name
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = "postgres"
  port                   = var.port
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.aws_db_sg.name
  vpc_security_group_ids = [var.vpc_sg_id]
  multi_az               = false # Outside of scope of free tier
  publicly_accessible    = true
  skip_final_snapshot    = true
  apply_immediately      = true # If this is false, changes won't take effect until next maintenance window
}

resource "aws_db_subnet_group" "aws_db_sg" {
  name       = var.name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.name
  }
}