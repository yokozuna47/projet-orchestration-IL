resource "kubernetes_service_v1" "web" {
  metadata {
    name      = "web-svc"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  spec {
    selector = {
      app = "web"
    }
    type = "NodePort"
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_ingress_v1" "web" {
  metadata {
    name      = "web-ingress"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  spec {
    rule {
      host = var.hote_ingress
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.web.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "web" {
  metadata {
    name      = "web-hpa"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment_v1.web.metadata[0].name
    }
    min_replicas = var.replicas
    max_replicas = 8
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 50
        }
      }
    }
  }
}
