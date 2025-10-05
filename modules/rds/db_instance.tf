resource "aws_db_instance" "mysql" {
  identifier = "${var.db_name_prefix}-server"
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "password1234"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "${var.db_name_prefix}-server"
  }
}