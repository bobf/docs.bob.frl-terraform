resource "aws_security_group" "internal_http_sg" {
  name        = "internal_http_sg"
  description = "Internal HTTP Access"
  vpc_id      = aws_vpc.vpc_internal.id
}

resource "aws_vpc_security_group_ingress_rule" "internal_http_sg_ingress" {
  security_group_id = aws_security_group.internal_http_sg.id

  cidr_ipv4   = "172.30.0.0/16"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "internal_http_sg_egress" {
  security_group_id = aws_security_group.internal_http_sg.id

  cidr_ipv4   = "172.30.0.0/16"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}
