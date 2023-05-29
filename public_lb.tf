resource "aws_lb" "nlb_public" {
  name = "docs-bob-frl-public-gateway"
  load_balancer_type = "network"
  internal = false
  subnets = [aws_subnet.public_lb_subnet_01.id, aws_subnet.public_lb_subnet_02.id]
}
