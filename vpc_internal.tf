resource "aws_vpc" "vpc_internal" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_internal"
  }
}

resource "aws_subnet" "internal_subnet_01" {
  vpc_id = aws_vpc.vpc_internal.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "internal_subnet_01"
  }
}

resource "aws_subnet" "internal_subnet_02" {
  vpc_id = aws_vpc.vpc_internal.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "internal_subnet_02"
  }
}

resource "aws_route_table" "internal_rt" {
  vpc_id = aws_vpc.vpc_internal.id

  route {
    cidr_block = "172.30.1.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block = "172.30.2.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block = "172.30.3.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block = "172.30.4.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block = "172.30.5.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.internal_nat_gateway.id
  }

  tags = {
    Name = "internal_rt"
  }
}

resource "aws_route_table_association" "internal_subnet_01_public_rt" {
  route_table_id = aws_route_table.internal_rt.id
  subnet_id      = aws_subnet.internal_subnet_01.id
}

resource "aws_route_table_association" "internal_subnet_02_public_rt" {
  route_table_id = aws_route_table.internal_rt.id
  subnet_id      = aws_subnet.internal_subnet_02.id
}

resource "aws_subnet" "internal_nat_gateway_subnet" {
  vpc_id = aws_vpc.vpc_internal.id
  cidr_block = "10.0.9.0/24"
  availability_zone = "eu-north-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "internal_nat_gateway_subnet"
  }
}
