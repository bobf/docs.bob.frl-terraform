resource "aws_lb_target_group" "tg_public_http" {
  name = "tg-public-http"
  vpc_id = aws_vpc.vpc_public.id
  port = 80
  protocol = "TCP"
  target_type = "alb"

  tags = {
    Name = "tg_public_http"
  }
}

resource "aws_lb_target_group_attachment" "tga_public_http" {
  target_group_arn = aws_lb_target_group.tg_public_http.arn
  target_id = aws_lb.internal_alb.id
  port = 80
}

resource "aws_lb_listener" "nlb_public_listener_http" {
  load_balancer_arn = aws_lb.nlb_public.arn
  port = 80
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_public_http.id
  }

  tags = {
    Name = "nlb_public_listener_http"
  }
}
