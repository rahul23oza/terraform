resource "aws_security_group" "alb_sg" {
  name        = var.lb_sg_name
  description = var.lb_sg_description
  vpc_id = var.vpc_id_sg
    # tags = {
    #   Name = var.lb_sg_tag_name
    #   purpose = var.lb_sg_purpose
    # }
 
  dynamic "ingress" {
    for_each = var.lb_ingress_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description  = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.lb_egress_rules

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description  = egress.value.description
    }
}
}