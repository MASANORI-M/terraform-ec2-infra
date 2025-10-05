resource "aws_instance" "api_server_01" {
  ami                    = "ami-094dc5cf74289dfbc"
  instance_type          = "t2.micro"
  subnet_id              = var.api_01_subnet_id
  vpc_security_group_ids = [var.api_sg_id]
  key_name               = "test-ec2-key"
  availability_zone      = "ap-northeast-1a"

  tags = {
    Name = "${var.api_name_prefix}-server-01"
  }
}

resource "aws_instance" "api_server_02" {
  ami                    = "ami-094dc5cf74289dfbc"
  instance_type          = "t2.micro"
  subnet_id              = var.api_02_subnet_id
  vpc_security_group_ids = [var.api_sg_id]
  key_name               = "test-ec2-key"
  availability_zone      = "ap-northeast-1c"

  tags = {
    Name = "${var.api_name_prefix}-server-02"
  }
}

# ターゲットグループアタッチメント
resource "aws_lb_target_group_attachment" "api_server_01_tg_attachment" {
  target_group_arn = var.elb_tg_arn
  target_id = aws_instance.api_server_01.id
  port = 80
}

resource "aws_lb_target_group_attachment" "api_server_02_tg_attachment" {
  target_group_arn = var.elb_tg_arn
  target_id = aws_instance.api_server_02.id
  port = 80
}