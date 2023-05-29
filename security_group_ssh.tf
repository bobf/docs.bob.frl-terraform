resource "aws_security_group" "vpc_public_ssh" {
  name        = "vpc_public_ssh"
  description = "Public SSH Access"
  vpc_id      = aws_vpc.vpc_public.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_public_ingress_ssh" {
  security_group_id = aws_security_group.vpc_public_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_public_egress_internet" {
  security_group_id = aws_security_group.vpc_public_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}



resource "aws_security_group" "vpc_internal_ssh" {
  name        = "vpc_internal_ssh"
  description = "Internal SSH Access"
  vpc_id      = aws_vpc.vpc_internal.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_internal_ingress_ssh" {
  security_group_id = aws_security_group.vpc_internal_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_internal_egress_internet" {
  security_group_id = aws_security_group.vpc_internal_ssh.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
