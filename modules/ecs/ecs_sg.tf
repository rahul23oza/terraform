resource "aws_security_group" "ecs_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id       = var.vpc_id
  
  
    tags = {
      Name = var.sg_tag_name
    }
 
  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description  = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description  = egress.value.description
    }
}
}