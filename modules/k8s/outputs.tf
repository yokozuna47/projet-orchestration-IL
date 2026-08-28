output "namespace" {
  value = kubernetes_namespace_v1.projet.metadata[0].name
}

output "hote_ingress" {
  value = var.hote_ingress
}

output "nodeport" {
  value = kubernetes_service_v1.web.spec[0].port[0].node_port
}
