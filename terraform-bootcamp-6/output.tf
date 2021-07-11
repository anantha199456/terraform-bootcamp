  
output "jenkins_url" {
  value = "http://${module.create_load_balancer.load_balancer_dns_name}:${var.application_port["port"]}"
}