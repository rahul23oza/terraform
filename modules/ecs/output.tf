output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

output "aws_ecs_service_id" {
  value = aws_ecs_service.ecs_service.id
}