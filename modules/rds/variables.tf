variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_sg_id" {
  type = string
}

variable "api_sg_id" {
  type = string
}

variable "db_name_prefix" {
  type = string
}