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

  tags = {
    Name = "internal_subnet_01"
  }
}

resource "aws_subnet" "internal_subnet_02" {
  vpc_id = aws_vpc.vpc_internal.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1b"
  tags = {
    Name = "internal_subnet_02"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.internal_subnet_01.id
  private_ip = "10.0.1.22"
  availability_zone = "eu-north-1a"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id]
  key_name = "docs.bob.frl"

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "web_host_01" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.small"
  subnet_id = aws_subnet.internal_subnet_01.id
  private_ip = "10.0.1.5"
  availability_zone = "eu-north-1a"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id]

  tags = {
    Name = "web_host_01"
  }
}

resource "aws_instance" "web_host_02" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.small"
  subnet_id = aws_subnet.internal_subnet_02.id
  availability_zone = "eu-north-1b"
  private_ip = "10.0.2.5"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id]

  tags = {
    Name = "web_host_02"
  }
}

resource "aws_route_table" "internal_rt" {
  vpc_id = aws_vpc.vpc_internal.id

  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
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
