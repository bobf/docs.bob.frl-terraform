resource "aws_lb" "nlb_internal" {
  name = "docs-bob-frl-internal-http"
  internal = true
  load_balancer_type = "network"
  subnets = [aws_subnet.internal_subnet_01.id, aws_subnet.internal_subnet_02.id]
  tags = {
    Name = "nlb_internal"
  }
}

resource "aws_lb_target_group" "tg_internal_http" {
  name = "tg-internal-http"
  vpc_id = aws_vpc.vpc_internal.id
  port = 80
  protocol = "TCP"
  target_type = "ip"
}

resource "aws_lb_target_group_attachment" "tga_internal_http_host_01" {
  target_group_arn = aws_lb_target_group.tg_internal_http.id
  target_id = "10.0.1.5"
  port = 80
}


resource "aws_lb_target_group_attachment" "tga_internal_http_host_02" {
  target_group_arn = aws_lb_target_group.tg_internal_http.id
  target_id = "10.0.2.5"
  port = 80
}

resource "aws_lb_listener" "nlb_internal_listener_http" {
  load_balancer_arn = aws_lb.nlb_internal.arn
  port = 80
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_internal_http.arn
  }

  tags = {
    Name = "nlb_internal_listener_http"
  }
}
