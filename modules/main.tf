provider "aws" {
  region = var.aws_region
}

locals {
  app_name = "base"
  elb_name = "elb"
  web_name = "web"
  api_name = "api"
  db_name = "db"
  app_name_prefix = "${var.env}-${local.app_name}"
  elb_name_prefix = "${var.env}-${local.elb_name}"
  web_name_prefix = "${var.env}-${local.web_name}"
  api_name_prefix = "${var.env}-${local.api_name}"
  db_name_prefix  = "${var.env}-${local.db_name}"
}

module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  app_name_prefix = local.app_name_prefix
}

module "network" {
  source = "./network"
  domain_name = var.domain_name
  app_name_prefix = local.app_name_prefix

  elb_dns_name = module.elb.elb_dns_name
  elb_zone_id = module.elb.elb_zone_id
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.vpc_id
  elb_01_cidr = var.elb_01_cidr
  elb_02_cidr = var.elb_02_cidr
  api_01_cidr = var.api_01_cidr
  api_02_cidr = var.api_02_cidr
  db_01_cidr = var.db_01_cidr
  db_02_cidr = var.db_02_cidr
  elb_name_prefix = local.elb_name_prefix
  api_name_prefix = local.api_name_prefix
  db_name_prefix = local.db_name_prefix
}

module "security_group" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
  elb_sg_id = module.security_group.elb_sg_id
  api_sg_id = module.security_group.api_sg_id
  elb_name_prefix = local.elb_name_prefix
  api_name_prefix = local.api_name_prefix
  db_name_prefix = local.db_name_prefix
}

module "rtb" {
  source = "./rtb"
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
  elb_01_subnet_id = module.subnet.elb_01_subnet_id
  elb_02_subnet_id = module.subnet.elb_02_subnet_id
  api_01_subnet_id = module.subnet.api_01_subnet_id
  api_02_subnet_id = module.subnet.api_02_subnet_id
  db_01_subnet_id = module.subnet.db_subnet_01_id
  db_02_subnet_id = module.subnet.db_subnet_02_id
  elb_name_prefix = local.elb_name_prefix
  api_name_prefix = local.api_name_prefix
  db_name_prefix = local.db_name_prefix
}

module "web" {
  source = "./web"
  domain_name = var.domain_name
  certificate_arn = module.network.certificate_arn
  web_name_prefix = local.web_name_prefix
}

module "elb" {
  source = "./elb"
  vpc_id = module.vpc.vpc_id

  elb_subnet_ids = module.subnet.elb_subnet_ids
  elb_sg_id = module.security_group.elb_sg_id
  api_certificate_arn = module.network.api_certificate_arn
  elb_name_prefix = local.elb_name_prefix
}

module "ec2" {
  source = "./ec2"
  api_01_subnet_id = module.subnet.api_01_subnet_id
  api_02_subnet_id = module.subnet.api_02_subnet_id
  api_sg_id = module.security_group.api_sg_id
  elb_tg_arn = module.elb.elb_tg_arn
  api_name_prefix = local.api_name_prefix
}

module "rds" {
  source = "./rds"
  vpc_id = module.vpc.vpc_id
  db_subnet_ids = [
    module.subnet.db_subnet_01_id,
    module.subnet.db_subnet_02_id
  ]
  db_sg_id = module.security_group.db_sg_id
  api_sg_id = module.security_group.api_sg_id
  db_name_prefix = local.db_name_prefix
}