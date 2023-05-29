resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_subnet" "nat_gateway_subnet" {
  vpc_id = aws_vpc.vpc_public.id
  cidr_block = "172.30.3.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "nat_gateway_subnet"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.nat_gateway_subnet.id

  tags = {
    Name = "nat_gateway"
  }

  depends_on = [aws_internet_gateway.vpc_public_igw]
}

resource "aws_route_table" "public_nat_rt" {
  vpc_id = aws_vpc.vpc_public.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_public_igw.id
  }

  route {
    cidr_block        = "10.0.1.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block        = "10.0.2.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  tags = {
    Name = "public_nat_rt"
  }
}

resource "aws_route_table_association" "nat_gateway_subnet" {
  route_table_id = aws_route_table.public_nat_rt.id
  subnet_id      = aws_subnet.nat_gateway_subnet.id
}
