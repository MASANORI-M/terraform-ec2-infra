resource "aws_subnet" "elb_subnet-01" {
  vpc_id = var.vpc_id
  cidr_block = var.elb_01_cidr
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.elb_name_prefix}-subnet-01"
  }
}

resource "aws_subnet" "elb_subnet-02" {
  vpc_id = var.vpc_id
  cidr_block = var.elb_02_cidr
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.elb_name_prefix}-subnet-02"
  }
}