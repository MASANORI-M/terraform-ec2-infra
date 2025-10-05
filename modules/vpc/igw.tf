resource "aws_internet_gateway" "base_igw" {
  vpc_id = aws_vpc.base_vpc.id

  tags = {
    Name = "${var.app_name_prefix}-ig"
  }
}