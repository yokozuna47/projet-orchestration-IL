output "url_alb" {
  value = "http://${aws_lb.principal.dns_name}"
}

output "url_ecr" {
  value = aws_ecr_repository.app.repository_url
}

output "nom_cluster" {
  value = aws_ecs_cluster.principal.name
}

output "nom_service" {
  value = aws_ecs_service.app.name
}
