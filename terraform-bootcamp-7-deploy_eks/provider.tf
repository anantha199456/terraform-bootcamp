provider "kubernetes" {
  config_path = "~/.kube/config"
  # host                   = data.aws_eks_cluster.cluster.endpoint
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  # token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
  # version                = "~> 1.9"
}

data "kubernetes_all_namespaces" "all_ns" {

}

output "all_ns" {
  value = data.kubernetes_all_namespaces.all_ns.namespaces
}