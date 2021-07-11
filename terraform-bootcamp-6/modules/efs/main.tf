#Creating EFS
resource "aws_efs_file_system" "aws_efs_file_system" {
  creation_token = var.name

  tags = {
    Name = var.name
  }
}

#Creating moint point
resource "aws_efs_mount_target" "aws_efs_mount_target" {
    for_each = toset(var.subnet_ids)
    file_system_id = aws_efs_file_system.aws_efs_file_system.id
    subnet_id      = each.value
    security_groups = [var.security_groups]
}