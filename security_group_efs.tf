resource "aws_security_group" "sg_efs" {
  name        = "sg_efs"
  description = "EFS Access"
  vpc_id      = aws_vpc.vpc_internal.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_efs_ingress" {
  security_group_id = aws_security_group.sg_efs.id

  cidr_ipv4   = "10.0.0.0/8"
  from_port   = 2049
  to_port     = 2049
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_efs_egress" {
  security_group_id = aws_security_group.sg_efs.id

  cidr_ipv4   = "10.0.0.0/8"
  from_port   = 2049
  to_port     = 2049
  ip_protocol = "tcp"
}
