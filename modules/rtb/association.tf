resource "aws_route_table_association" "elb_01_rtb_assoc" {
  subnet_id = var.elb_01_subnet_id
  route_table_id = aws_route_table.elb_rtb.id
}

resource "aws_route_table_association" "elb_02_rtb_assoc" {
  subnet_id = var.elb_02_subnet_id
  route_table_id = aws_route_table.elb_rtb.id
}

resource "aws_route_table_association" "api_01_rtb_assoc" {
  subnet_id = var.api_01_subnet_id
  route_table_id = aws_route_table.api_rtb.id
}

resource "aws_route_table_association" "api_02_rtb_assoc" {
  subnet_id = var.api_02_subnet_id
  route_table_id = aws_route_table.api_rtb.id
}

resource "aws_route_table_association" "db_01_rtb_assoc" {
  subnet_id = var.db_01_subnet_id
  route_table_id = aws_route_table.db_rtb.id
}

resource "aws_route_table_association" "db_02_rtb_assoc" {
  subnet_id = var.db_02_subnet_id
  route_table_id = aws_route_table.db_rtb.id
}