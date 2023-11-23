resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 2
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#Automatically scale capacity up by one -- DEFAULT
# resource "aws_appautoscaling_policy" "ecs_policy_up" {
#   name               = "scale-down"
#   policy_type        = "StepScaling"
#   resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     cooldown                = 60
#     metric_aggregation_type = "Maximum"

#     step_adjustment {
#       metric_interval_upper_bound = 0
#       scaling_adjustment          = -1
#     }
#   }
# }
#----------------------------------------------------------------

resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageCPUUtilization"
   }
 
   target_value       = 20
  }
}


#----------------------------------------------------------------

# resource "aws_autoscaling_group" "my_asg" {
#   name                 = "my-asg"
#   vpc_zone_identifier = ["subnet-039de8362c35f1ef7", "subnet-0b0e5aaa25e0508bf"]  # Replace with your subnet IDs
#   launch_template {
#     id = aws_launch_template.my_launch_template.id
#   }
#   desired_capacity     = 2  # Adjust as needed
#   max_size             = 3  # Adjust as needed
#   min_size             = 1  # Adjust as needed
# }

# resource "aws_launch_template" "my_launch_template" {
#   name = "my-launch-template"
# #   version = "$Latest"  # You can specify a specific version if needed

#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size = 30
#       volume_type = "gp2"
#     }
#   }
# }
# resource "aws_ecs_capacity_provider" "fargate_capacity_provider" {
#   name = "asg"
#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
#     managed_termination_protection = "DISABLED"
#   }
# }

# resource "aws_autoscaling_group" "asg" {
#   name                 = "asg"
#   max_size             = 2
#   min_size             = 1
#   desired_capacity     = 1
#   vpc_zone_identifier  = var.alb_subnets # Replace with your subnet IDs
# #   health_check_type    = "ELB"
#   health_check_grace_period = 300
#   force_delete         = true
# }

# resource "aws_appautoscaling_target" "asg_target" {
#   max_capacity = 5
#   min_capacity = 1
#   # resource_id = "service/${var.cluster_name}/${var.svc_name}"
#   resource_id = aws_ecs_service.ecs_service.name
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace = "ecs"
# }

# resource "aws_appautoscaling_policy" "dev_to_memory" {
#   name               = "dev-to-memory"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.asg_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.asg_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.asg_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#     }

#     target_value       = 80
#   }
# }

# resource "aws_appautoscaling_policy" "dev_to_cpu" {
#   name = "dev-to-cpu"
#   policy_type = "TargetTrackingScaling"
#   resource_id = aws_appautoscaling_target.asg_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.asg_target.scalable_dimension
#   service_namespace = aws_appautoscaling_target.asg_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }

#     target_value = 60
#   }
# }