resource "aws_lb" "ecs_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnets

  enable_deletion_protection = false
  enable_http2        = true
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
     type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip" 
}

#  resource "aws_lb_target_group_attachment" "ecs_tg_attachment" {
#   target_group_arn = aws_lb_target_group.alb_target_group.arn
#   target_id        = var.lb_svc_id #aws_ecs_service.ecs_service.id
#   port             = var.lg_tg_attachment_port
# }


