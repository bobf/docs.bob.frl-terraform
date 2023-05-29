resource "aws_lb_target_group" "tg_internal_alb_http" {
  name = "tg-internal-alb-http"
  vpc_id = aws_vpc.vpc_public.id
  port = 80
  protocol = "HTTP"
  target_type = "ip"

  tags = {
    Name = "tg_internal_http"
  }
}

resource "aws_lb_target_group_attachment" "tga_internal_alb_http_host_01" {
  target_group_arn = aws_lb_target_group.tg_internal_alb_http.arn
  target_id = "10.0.1.5"
  availability_zone = "eu-north-1a"
  port = 80
}

resource "aws_lb_target_group_attachment" "tga_internal_alb_http_host_02" {
  target_group_arn = aws_lb_target_group.tg_internal_alb_http.arn
  target_id = "10.0.2.5"
  availability_zone = "eu-north-1b"
  port = 80
}

resource "aws_lb" "internal_alb" {
  name = "alb-internal"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.public_https_sg.id, aws_security_group.public_http_sg.id]
  subnets = [aws_subnet.public_subnet_01.id, aws_subnet.public_subnet_02.id]
}

resource "aws_lb_listener" "alb_internal_listener_https" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port = "443"
  protocol = "HTTPS"
  certificate_arn = "arn:aws:acm:eu-north-1:987373494809:certificate/31c84121-aec6-4523-8983-17e640177964"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg_internal_alb_http.arn
  }
}

resource "aws_lb_listener" "alb_internal_listener_http" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
