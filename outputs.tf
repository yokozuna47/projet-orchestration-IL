output "ecs_url_alb" {
  value = module.ecs.url_alb
}

output "ecs_url_ecr" {
  value = module.ecs.url_ecr
}

output "k8s_namespace" {
  value = module.k8s.namespace
}

output "k8s_hote_ingress" {
  value = module.k8s.hote_ingress
}

output "k8s_nodeport" {
  value = module.k8s.nodeport
}
