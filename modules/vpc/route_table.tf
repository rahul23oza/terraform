resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public Route Table"
  }
}

#subnet association for PUBLIC
resource "aws_route_table_association" "public_subnet_asso" {
  # count = length(var.public_subnet_cidr_block)
  for_each         = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_route_table_association" "public_subnet_asso_2" {
#   subnet_id      = aws_subnet.public-subnet-2.id
#   route_table_id = aws_route_table.public_route_table.id
# }


#Route table for PRIVATE
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.my_nat_gateway.id
    }
  # route {
  #   cidr_block = "0.0.0.0/0"
  # }
  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.igw.id
  # }
 
  tags = {
    Name = "private Route Table"
  }
}

#subnet association for PRIVATE
resource "aws_route_table_association" "private_subnet_asso" {
  for_each = aws_subnet.private-subnet
  # count = length(var.private_subnet_cidr_block)
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
  
}

# resource "aws_route_table_association" "private_subnet_asso_2" {
#   subnet_id      = aws_subnet.private-subnet-2.id
#   route_table_id = aws_route_table.private_route_table.id
# }