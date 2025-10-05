variable "vpc_id" {
  type = string
}

variable "elb_subnet_ids" {
  type = list(string)
}

variable "elb_sg_id" {
  type = string
}

variable "api_certificate_arn" {
  type = string
}

variable "elb_name_prefix" {
  type = string
}