resource "aws_subnet" "db_subnet_01" {
  vpc_id = var.vpc_id
  cidr_block = var.db_01_cidr
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.db_name_prefix}-subnet-01"
  }
}

resource "aws_subnet" "db_subnet_02" {
  vpc_id = var.vpc_id
  cidr_block = var.db_02_cidr
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.db_name_prefix}-subnet-02"
  }
}