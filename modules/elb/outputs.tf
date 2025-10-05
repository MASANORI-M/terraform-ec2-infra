output "elb_id" {
  value = aws_lb.elb.id
}

output "elb_arn" {
  value = aws_lb.elb.arn
}

output "elb_dns_name" {
  value = aws_lb.elb.dns_name
}

output "elb_zone_id" {
  value = aws_lb.elb.zone_id
}

output "elb_tg_arn" {
  value = aws_lb_target_group.elb_tg.arn
}

output "elb_tg_name" {
  value = aws_lb_target_group.elb_tg.name
}