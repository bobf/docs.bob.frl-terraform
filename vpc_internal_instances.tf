resource "aws_instance" "bastion" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.internal_subnet_01.id
  private_ip = "10.0.1.22"
  availability_zone = "eu-north-1a"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id]
  key_name = "docs.bob.frl"

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "web_host_01" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.small"
  subnet_id = aws_subnet.internal_subnet_01.id
  private_ip = "10.0.1.5"
  availability_zone = "eu-north-1a"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id, aws_security_group.internal_http_sg.id]
  key_name = "docs.bob.frl"

  tags = {
    Name = "web_host_01"
  }
}

resource "aws_instance" "web_host_02" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.small"
  subnet_id = aws_subnet.internal_subnet_02.id
  availability_zone = "eu-north-1b"
  private_ip = "10.0.2.5"
  vpc_security_group_ids = [aws_security_group.vpc_internal_ssh.id, aws_security_group.internal_http_sg.id]
  key_name = "docs.bob.frl"

  tags = {
    Name = "web_host_02"
  }
}
