resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}