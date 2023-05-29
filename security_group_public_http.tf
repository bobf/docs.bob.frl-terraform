resource "aws_security_group" "public_http_sg" {
  name        = "public_http_sg"
  description = "Public HTTP Access"
  vpc_id      = aws_vpc.vpc_public.id
}

resource "aws_vpc_security_group_ingress_rule" "public_http_sg_ingress" {
  security_group_id = aws_security_group.public_http_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "public_http_sg_egress" {
  security_group_id = aws_security_group.public_http_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
