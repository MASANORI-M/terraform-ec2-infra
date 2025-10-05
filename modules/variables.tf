variable "env" {
  type = string
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "vpcのCIDRブロック"
  type = string
  default = "10.0.0.0/16"
}

variable "elb_01_cidr" {
  description = "elb_subnet_01のCIDRブロック"
  type = string
  default = "10.0.0.0/24"
}

variable "elb_02_cidr" {
  description = "elb_subnet_02のCIDRブロック"
  type = string
  default = "10.0.1.0/24"
}

variable "api_01_cidr" {
  description = "api_subnet_01のCIDRブロック"
  type = string
  default = "10.0.2.0/24"
}

variable "api_02_cidr" {
  description = "api_subnet_02のCIDRブロック"
  type = string
  default = "10.0.3.0/24"
}

variable "db_01_cidr" {
  description = "db_01_subnetのCIDRブロック"
  type = string
  default = "10.0.4.0/24"
}

variable "db_02_cidr" {
  description = "db_02_subnetのCIDRブロック"
  type = string
  default = "10.0.5.0/24"
}

variable "domain_name" {
  description = "ドメイン名"
  type = string
  default = "test-mm-sprint.com"
}