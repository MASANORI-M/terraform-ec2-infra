output "vpc_id" {
  value = aws_vpc.base_vpc.id
}

output "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  value = aws_vpc.base_vpc.cidr_block
}

output "igw_id" {
  value = aws_internet_gateway.base_igw.id
}