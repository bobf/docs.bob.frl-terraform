resource "aws_ec2_transit_gateway" "public_internal_tgw" {
  description = "Internal/Public gateway"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "public_internal_tgw_public" {
  transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  subnet_ids = [aws_subnet.public_subnet_01.id, aws_subnet.public_subnet_02.id]
  vpc_id = aws_vpc.vpc_public.id
  tags = {
    Name = "public_tgw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "public_internal_tgw_internal" {
  transit_gateway_id = aws_ec2_transit_gateway.public_internal_tgw.id
  subnet_ids = [aws_subnet.internal_subnet_01.id, aws_subnet.internal_subnet_02.id]
  vpc_id = aws_vpc.vpc_internal.id
  tags = {
    Name = "internal_tgw"
  }
}
