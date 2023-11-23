resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.td_family 
  network_mode             = var.td_network_mode
  requires_compatibilities = var.td_requires_compatibilities
  cpu                      = var.td_cpu 
  memory                   = var.td_memory  

  execution_role_arn = var.td_execution_role_arn

  container_definitions = var.td_container_definitions_json
}