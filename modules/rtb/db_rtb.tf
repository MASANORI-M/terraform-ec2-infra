resource "aws_route_table" "db_rtb" {
  vpc_id = var.vpc_id

  # route = {
  #   cidr_block = "0.0.0.0/0"
  # }

  tags = {
    Name = "${var.db_name_prefix}-rtb"
  }
}