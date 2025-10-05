output "domain_name" {
  value = var.domain_name
}

output "zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
}

output "name_server" {
  value = aws_route53_zone.route53_zone.name_servers
}

output "certificate_arn" {
  value = aws_acm_certificate.acm.arn
}

output "certificate_validation_arn" {
  value = aws_acm_certificate_validation.acm_certificate_validatio.certificate_arn
}

output "api_certificate_arn" {
  value = aws_acm_certificate.api_cert.arn
}

output "api_certificate_validation_arn" {
  value = aws_acm_certificate_validation.api_acm_certificate_validation.certificate_arn
}