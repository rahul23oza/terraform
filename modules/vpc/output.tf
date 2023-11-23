output "SG" {
  value = aws_security_group.sg.id
}

# output "public_subnet_id_1" {
#   value = aws_subnet.public-subnet-1.id
# }

# output "public_subnet_id_2" {
#   value = aws_subnet.public-subnet-2.id
# }

# output "private_subnet_id_1" {
#   value = aws_subnet.private-subnet-1.id
# }

# output "private_subnet_id_2" {
#   value = aws_subnet.private-subnet-2.id
# }

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  # value = aws_subnet.public-subnet[*].id
  value = values(aws_subnet.public-subnet)[*].id
}

output "private_subnets" {
  # value = aws_subnet.private-subnet[*].id
    value = values(aws_subnet.private-subnet)[*].id
}