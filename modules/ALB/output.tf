output "alb_target_group" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}