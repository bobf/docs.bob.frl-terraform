resource "aws_security_group" "public_https_sg" {
  name        = "public_https_sg"
  description = "Public HTTPS Access"
  vpc_id      = aws_vpc.vpc_public.id
}

resource "aws_vpc_security_group_ingress_rule" "public_https_sg_ingress" {
  security_group_id = aws_security_group.public_https_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "public_https_sg_egress" {
  security_group_id = aws_security_group.public_https_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"
}
