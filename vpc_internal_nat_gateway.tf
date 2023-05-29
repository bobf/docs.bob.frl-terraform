resource "aws_eip" "internal_nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "internal_nat_gateway" {
  allocation_id = aws_eip.internal_nat_gateway_eip.id
  subnet_id     = aws_subnet.internal_nat_gateway_subnet.id

  tags = {
    Name = "nat_gateway"
  }

  depends_on = [aws_internet_gateway.internal_igw]
}

resource "aws_internet_gateway" "internal_igw" {
  vpc_id = aws_vpc.vpc_internal.id

  tags = {
    Name = "internal_igw"
  }
}

resource "aws_route_table" "internal_nat_rt" {
  vpc_id = aws_vpc.vpc_internal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internal_igw.id
  }
}

resource "aws_route_table_association" "internal_nat_rta" {
  route_table_id = aws_route_table.internal_nat_rt.id
  subnet_id      = aws_subnet.internal_nat_gateway_subnet.id
}
