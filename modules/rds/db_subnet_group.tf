resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.db_name_prefix}-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.db_name_prefix}-subnet-group"
  }
}