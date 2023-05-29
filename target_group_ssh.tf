resource "aws_lb_target_group" "tg_public_ssh" {
  name = "tg-public-ssh"
  vpc_id = aws_vpc.vpc_public.id
  port = 22
  protocol = "TCP"
  target_type = "ip"

  tags = {
    Name = "public_ssh_tg"
  }
}

resource "aws_lb_target_group_attachment" "tga_public_ssh" {
  target_group_arn = aws_lb_target_group.tg_public_ssh.arn
  target_id = "10.0.1.22"
  availability_zone = "eu-north-1a"
  port = 22
}

resource "aws_lb_listener" "nlb_public_listener_ssh" {
  load_balancer_arn = aws_lb.nlb_public.arn
  port = 22
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_public_ssh.arn
  }

  tags = {
    Name = "nlb_public_listener_ssh"
  }
}
