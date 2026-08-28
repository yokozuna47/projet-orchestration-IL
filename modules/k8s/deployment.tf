resource "kubernetes_namespace_v1" "projet" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map_v1" "app" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  data = {
    APP_NOM = "Projet Orchestration"
    APP_ENV = "production"
  }
}

resource "kubernetes_deployment_v1" "web" {
  metadata {
    name      = "web"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = "web"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 0
      }
    }
    template {
      metadata {
        labels = {
          app = "web"
        }
      }
      spec {
        container {
          name  = "web"
          image = var.image
          port {
            container_port = 80
          }
          env_from {
            config_map_ref {
              name = kubernetes_config_map_v1.app.metadata[0].name
            }
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
          resources {
            requests = {
              cpu    = "50m"
              memory = "32Mi"
            }
            limits = {
              cpu    = "150m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}
