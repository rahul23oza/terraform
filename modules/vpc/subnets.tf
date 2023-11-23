resource "aws_subnet" "public-subnet" {
  for_each = var.public_subnets
  vpc_id     = aws_vpc.vpc.id
  # count = length(var.public_subnet_cidr_block)
  # cidr_block = var.public_subnet_cidr_block1
  # availability_zone = "us-west-1a"
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private-subnet" { 
  for_each = var.private_subnets
  vpc_id     = aws_vpc.vpc.id
  # count = length(var.private_subnet_cidr_block)
  # cidr_block = var.private_subnet_cidr_block1
  # availability_zone = "us-west-1a"
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = "private-subnet-${each.key}"
  }
}


# resource "aws_subnet" "public-subnet-2" {
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = var.public_subnet_cidr_block2
#   # count = 2
#   availability_zone = "us-west-1b"
#   tags = {
#     Name = "public-subnet-2"
#   }
# }

# resource "aws_subnet" "private-subnet-2" { 
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = var.private_subnet_cidr_block2
#   availability_zone = "us-west-1b"
#   tags = {
#     Name = "private-subnet-2"
#   }
# }