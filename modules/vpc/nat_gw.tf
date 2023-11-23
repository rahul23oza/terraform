resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = values(aws_subnet.public-subnet)[0].id
  tags = {
    Name = "nat-gateway"
  }

  depends_on    = [aws_subnet.public-subnet, aws_eip.nat_eip]
}