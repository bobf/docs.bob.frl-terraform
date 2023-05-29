resource "aws_vpc" "vpc_public" {
  cidr_block = "172.30.0.0/16"

  tags = {
    Name = "vpc_public"
  }
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id = aws_vpc.vpc_public.id
  cidr_block = "172.30.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "public_subnet_01"
  }
}

resource "aws_subnet" "public_subnet_02" {
  vpc_id = aws_vpc.vpc_public.id
  cidr_block = "172.30.2.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = "public_subnet_02"
  }
}

resource "aws_internet_gateway" "vpc_public_igw" {
  vpc_id = aws_vpc.vpc_public.id

  tags = {
    Name = "public_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_public.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_subnet_01_public_rt" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_01.id
}

resource "aws_route_table_association" "public_subnet_02_public_rt" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_02.id
}

resource "aws_subnet" "public_lb_subnet_01" {
  vpc_id = aws_vpc.vpc_public.id
  cidr_block = "172.30.4.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_lb_subnet_01"
  }
}

resource "aws_subnet" "public_lb_subnet_02" {
  vpc_id = aws_vpc.vpc_public.id
  cidr_block = "172.30.5.0/24"
  availability_zone = "eu-north-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_lb_subnet_01"
  }
}

resource "aws_route_table" "public_lb_rt" {
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
    Name = "public_lb_rt"
  }
}

resource "aws_route_table_association" "public_lb_subnet_01_rta" {
  route_table_id = aws_route_table.public_lb_rt.id
  subnet_id      = aws_subnet.public_lb_subnet_01.id
}

resource "aws_route_table_association" "public_lb_subnet_02_rta" {
  route_table_id = aws_route_table.public_lb_rt.id
  subnet_id      = aws_subnet.public_lb_subnet_02.id
}
