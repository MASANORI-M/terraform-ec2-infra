output "elb_01_subnet_id" {
  value = aws_subnet.elb_subnet-01.id
}

output "elb_02_subnet_id" {
  value = aws_subnet.elb_subnet-02.id
}

output "elb_subnet_ids" {
  value = [
    aws_subnet.elb_subnet-01.id,
    aws_subnet.elb_subnet-02.id  
  ]
}

output "api_01_subnet_id" {
  value = aws_subnet.api_subnet-01.id
}

output "api_02_subnet_id" {
  value = aws_subnet.api_subnet-02.id
}

output "db_subnet_01_id" {
  value = aws_subnet.db_subnet_01.id
}

output "db_subnet_02_id" {
  value = aws_subnet.db_subnet_02.id
}