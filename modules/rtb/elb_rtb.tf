resource "aws_route_table" "elb_rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.elb_name_prefix}-rtb"
  }
}