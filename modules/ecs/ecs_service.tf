resource "aws_ecs_service" "ecs_service" {
  name            = var.svc_name 
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = var.svc_launch_type 
  desired_count   = var.svc_desired_count 

  network_configuration {
    # subnets         = ["subnet-1", "subnet-2"] 
    # security_groups = [aws_security_group.ecs_security_group.id]

    assign_public_ip = var.svc_assign_public_ip
    security_groups = [aws_security_group.ecs_sg.id]
    subnets = var.svc_subnets
  }

   load_balancer {
    target_group_arn = var.svc_lb_target_group_arn
    container_name   = var.svc_lb_container_name
    container_port   = var.svc_lb_container_port
  }

  # depends_on = [aws_alb_listener.testapp, aws_iam_role_policy_attachment.ecs_task_execution_role]
  # Depend on ALB and ASG
  # depends_on = [
  #   aws_appautoscaling_target.asg_target
  # ]
   
  #  capacity_provider_strategy {
  #    capacity_provider = aws_autoscaling_group.my_asg.name
  #  }

}