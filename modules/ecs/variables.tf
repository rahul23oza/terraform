variable "cluster_name" {
  type = string
}

# ECS-SG
#SG name
variable "sg_name" {
  type = string
}

#SG tag
variable "sg_tag_name" {
  type = string
}

#SG description
variable "sg_description" {
  type = string
  }

variable "vpc_id" {
  # description = "This VPC ID we will take from VPC module"
  #  type        = tuple([  ])
}

variable "ingress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "egress_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

# ECS- TD

#Task-definition
variable "td_family" {
  type = string
}

variable "td_network_mode" {
    type = string
}

variable "td_requires_compatibilities" {
  type = set(string)
}

variable "td_execution_role_arn" {
  type = string
}


variable "td_cpu" {
  type = string
}

variable "td_memory" {
  type = string
}

variable "td_container_definitions_json" {
  description = "JSON-encoded container definitions"
}

# ECS - Service


variable "svc_name" {
  type = string
}


# variable "svc_td_name" {
#   description = "data block has been added onto PROD OR TEST main.tf file"
# }

variable "svc_desired_count" {
    description = "data block has been added onto PROD OR TEST main.tf file"
}

variable "svc_launch_type" {
  type = string
}

variable "svc_assign_public_ip" {
  type = bool
}

# variable "svc_security_groups" {
#   description = "get ID from output of ecs-module"
#   type = set(string)
# }

variable "svc_subnets" {
  type = list(string)
}

# svc lb
variable "svc_lb_target_group_arn" {
  type = string
}

variable "svc_lb_container_name" {
  type = string
}

variable "svc_lb_container_port" {
  type = number
}

# ASG - ECS

# variable "alb_subnets" {
# }

# variable "alb_resouceID" {
  
# }