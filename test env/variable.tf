# variable "access_key" {}
# variable "secret_key" {}

variable "regions" {
  type        = list(string)
  default     = ["us-east-1", "ap-south-1", "us-west-1"]
  description = "The AWS region where all resources will be provisioned."
}


variable "container_definitions" {
  description = "A list of container definitions to be used in the TD."
  default = {
    name  = "web-Container"
    image = "398412653278.dkr.ecr.us-west-1.amazonaws.com/java_aws:latest"
    portMappings = [
      {
        containerPort = 8080
        hostPort      = 8080
        appProtocol   = "http"
        name          = "encoding-server-8080-tcp"
        protocol      = "tcp"
      }
    ]
  }
}

# Used in ECS-Service
# variable "subnet_ids" {
#   description = "The subnets are used in ECS service and Load balancer tg."
#   type        = list(string)
#   default = [
#     "subnet-0cdd2590583a16dd5",
#     "subnet-0fb444678c6a79d18",
#     "subnet-0ac72695f3b4aa4d9",
#     "subnet-0c5bfb39d8b871a24"
#   ]
# }