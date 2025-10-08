resource "aws_security_group" "api_sg" {
  name        = "${var.api_name_prefix}-sg"
  description = "${var.api_name_prefix}-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [var.elb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.api_name_prefix}-sg"
  }
}