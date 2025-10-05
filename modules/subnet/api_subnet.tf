resource "aws_subnet" "api_subnet-01" {
  vpc_id = var.vpc_id
  cidr_block = var.api_01_cidr
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.api_name_prefix}-subnet-01"
  }
}

resource "aws_subnet" "api_subnet-02" {
  vpc_id = var.vpc_id
  cidr_block = var.api_02_cidr
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.api_name_prefix}-subnet-02"
  }
}