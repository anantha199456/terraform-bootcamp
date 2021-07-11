output "application_url" {
    value = "http://${module.create_load_balancer.load_balancer_dns_name}:${var.Jenkins_port_protocol["port"]}"
}

# output "password" {
#     value = module.create_post_rds.db_password
# }