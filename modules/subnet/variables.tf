variable "vpc_id" {
  type = string
}

variable "elb_01_cidr" {
  description = "elb_01のCIDRブロック"
  type        = string
}

variable "elb_02_cidr" {
  description = "elb_02のCIDRブロック"
  type        = string
}

variable "api_01_cidr" {
  description = "api_01のCIDRブロック"
  type        = string
}

variable "api_02_cidr" {
  description = "api_02のCIDRブロック"
  type        = string
}

variable "db_01_cidr" {
  description = "dbのCIDRブロック"
  type        = string
}

variable "db_02_cidr" {
  description = "dbのCIDRブロック"
  type        = string
}

variable "elb_name_prefix" {
  type = string
}

variable "api_name_prefix" {
  type = string
}

variable "db_name_prefix" {
  type = string
}