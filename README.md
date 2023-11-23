# terraform
terraform code with multiple custom modules.

-->  FYI: I used aws cli for access and secret key configure.

- Creat Custom VPC module
- Creat Custom IAM module for specific role which is used in ECS service
- creat ALB for ECS service
- creat ECS module with cluster, task definition, service , and asg configuration in ECS service.

- I use custom VPC, created public and private subnets, NAT, Internet gateways, route table and EIP. 
- ECS cluster I will deploy it onto private subnets for security purposes. 
- Specifically in this project, I have deployed ALB onto Public subnet.
- I used NAT Gateway for internet connectivity into the Private subnet.

# Compulsory configuration
- First of all, need to create ECR Manually and push docker image onto ECR. Update variable in terraform root (test directory) in variables.tf file, one variable called container_definitions in this we need to add the URI of ECR image.
- because we don't used CI/CD pipeline so we have created customly.

# Terraform run

- goto test directory
- terraform init
- terraform validate
- terraform plan
- terraform apply
