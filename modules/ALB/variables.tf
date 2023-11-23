variable "alb_name" {
  type = string
}

variable "alb_subnets" {
  type = list(string)
}

variable "vpc_id_sg" {
  
}

# variable "alb_sg" {
#   type = set(string)
# }

variable "vpc_id" {
}

# ALB - SG

#SG name
variable "lb_sg_name" {
  type = string
}

#SG tag
# variable "lb_sg_tag_name" {
#   type = string
# }

# variable "lb_sg_purpose" {
#   type = string
# }

#SG description
variable "lb_sg_description" {
  type = string
  }

variable "lb_ingress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "lb_egress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

# ----
# variable "lg_tg_attachment_port" {
#   type = number
# }

# variable "lb_svc_id" {
  
# }