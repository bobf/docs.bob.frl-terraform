resource "aws_lb_target_group" "tg_public_https" {
  name = "tg-public-https"
  vpc_id = aws_vpc.vpc_public.id
  port = 443
  protocol = "TCP"
  target_type = "alb"

  tags = {
    Name = "tg_public_https"
  }
}

resource "aws_lb_target_group_attachment" "tga_public_https" {
  target_group_arn = aws_lb_target_group.tg_public_https.arn
  target_id = aws_lb.internal_alb.id
  port = 443
}

resource "aws_lb_listener" "nlb_public_listener_https" {
  load_balancer_arn = aws_lb.nlb_public.arn
  port = 443
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_public_https.id
  }

  tags = {
    Name = "nlb_public_listener_https"
  }
}
