output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.vpc_id
}

output "certificate_arn" {
  value = module.network.certificate_arn
}


output "elb_subnet_01_id" {
  value = module.subnet.elb_01_subnet_id
}

output "elb_subnet_02_id" {
  value = module.subnet.elb_02_subnet_id
}

output "public_subnet_ids" {
  value = module.subnet.elb_subnet_ids
}

output "api_subnet_01_id" {
  value = module.subnet.api_01_subnet_id
}

output "api_subnet_02_id" {
  value = module.subnet.api_02_subnet_id
}

output "db_subnet_01_id" {
  value = module.subnet.db_subnet_01_id
}

output "db_subnet_02_id" {
  value = module.subnet.db_subnet_02_id
}

output "elb_sg_id" {
  value = module.security_group.elb_sg_id
}

output "api_sg_id" {
  value = module.security_group.api_sg_id
}

output "db_sg_id" {
  value = module.security_group.db_sg_id
}