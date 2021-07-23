
resource "kubernetes_namespace" "tomcat_application" {
  
  metadata {
    name = var.name
    labels = {
      app = var.name
    }
  } 
}

resource "kubernetes_deployment" "tomcat_app" {
  metadata {
    name = var.name
    namespace = kubernetes_namespace.tomcat_application.id
    labels = {
      app = var.name
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }
      spec {
        container {
          image = var.image
          name = var.name
        }
      }
    }
  }
}

resource "kubernetes_service" "tomcat_application" {
  metadata {
    name = var.name
    namespace = var.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.tomcat_app.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }
    type = var.service_type
  }
}