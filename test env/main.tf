module "vpc" {
  source         = "../modules/vpc"
  vpc_name       = "Demo_VPC"
  vpc_cidr_block = "10.0.0.0/16"
  # public_subnet_cidr_block1  = "10.0.1.0/24"
  # public_subnet_cidr_block2  = "10.0.2.0/24"
  # private_subnet_cidr_block1 = "10.0.3.0/24"
  # private_subnet_cidr_block2 = "10.0.4.0/24"
  # public_subnet_az = ["us-west-1a", "us-west-1b"]
  # private_subnet_az = ["us-west-1a", "us-west-1b"]
  public_subnets = {
    1 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-west-1a"
    }

    2 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-west-1b"
    }
  }
  private_subnets = {
    1 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-west-1a"
    }

    2 = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-west-1b"
    }
  }
}

module "alb" {
  source   = "../modules/ALB"
  alb_name = "alb"
  # alb_subnets = [module.vpc.public_subnet_id_1, module.vpc.public_subnet_id_2]
  alb_subnets = module.vpc.public_subnets # here it will get both public subnets.
  vpc_id      = module.vpc.vpc_id
  # ALB - SG

  lb_sg_name        = "LB_SG"
  lb_sg_description = "for java app"
  vpc_id_sg         = module.vpc.vpc_id
  lb_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = ""
    }
  }

  lb_egress_rules = {
    all_traffic = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # All protocols
      cidr_blocks = ["0.0.0.0/0"]
      description = ""
    }
  }

}

module "ecs" {
  source       = "../modules/ecs"
  cluster_name = "TerraTest"

  #ECS-SG
  # ECS - SG

  sg_name        = "ecs-SG"
  sg_description = "this is for ecs security group for test server."
  sg_tag_name    = "ECS-SG"
  vpc_id         = module.vpc.vpc_id

  ingress_rules = {
    custom_tcp = {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = ""
    }
  }

  egress_rules = {
    all_traffic = {
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # All protocols
      cidr_blocks = ["0.0.0.0/0"]
      description = ""
    }
  }

  # ECS - TD

  td_family                     = "demo-fargate-task"
  td_requires_compatibilities   = ["FARGATE"]
  td_network_mode               = "awsvpc"
  td_cpu                        = "256" # 1 vCPU (1024 CPU units)
  td_memory                     = "512" # 1 GiB RAM (1024 MiB)
  td_execution_role_arn         = module.iam.iam_ecs_task_execution_role
  td_container_definitions_json = jsonencode([var.container_definitions])

  # ECS - Service
  svc_name          = "App_service"
  svc_launch_type   = "FARGATE"
  svc_desired_count = 1

  svc_assign_public_ip = true
  # svc_security_groups  = [module.ecs-module.ecs_sg_id]
  svc_subnets = module.vpc.private_subnets

  # ECS - Service - ALB
  svc_lb_target_group_arn = module.alb.alb_target_group
  svc_lb_container_name   = var.container_definitions.name
  svc_lb_container_port   = var.container_definitions.portMappings[0].containerPort

  # ECS - Service - ASG
  # alb_subnets = [module.vpc.public_subnet_id]
  # alb_resouceID = "service/TerraTest/App_service"
}


module "iam" {
  source = "../modules/IAM"
}

