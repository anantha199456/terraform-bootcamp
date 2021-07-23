output "server_ip" {
  value = aws_instance.dynamodb_app.public_ip
}