resource "kubernetes_network_policy_v1" "web_ingress_only" {
  metadata {
    name      = "web-depuis-ingress"
    namespace = kubernetes_namespace_v1.projet.metadata[0].name
  }
  spec {
    pod_selector {
      match_labels = {
        app = "web"
      }
    }
    policy_types = ["Ingress"]
    ingress {
      from {
        namespace_selector {
          match_labels = {
            "kubernetes.io/metadata.name" = "ingress-nginx"
          }
        }
      }
      ports {
        port     = 80
        protocol = "TCP"
      }
    }
  }
}
