terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
      configuration_aliases = [aws.virginia]
    }
  }
}

resource "aws_route53_zone" "route53_zone" {
  name = var.domain_name

  tags =  {
    Neme = "${var.app_name_prefix}-route53-zone"
  }
}

# ACM証明書（メインドメイン：web）
resource "aws_acm_certificate" "acm" {
  provider = aws.virginia
  domain_name = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags =  {
    Neme = "${var.app_name_prefix}-acm"
  }
}

# ACM証明書のDNS検証レコード
resource "aws_route53_record" "route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.acm.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.route53_zone.zone_id
}

# ACM証明書の検証
resource "aws_acm_certificate_validation" "acm_certificate_validatio" {
  provider          = aws.virginia
  certificate_arn = aws_acm_certificate.acm.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}


# サブドメイン用ACM証明書
resource "aws_acm_certificate" "api_cert" {
  domain_name = "api.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Neme = "${var.app_name_prefix}-api-acm"
  }
}

# サブドメイン用DNS検証レコード
resource "aws_route53_record" "api_route53_record" {
  for_each = {
    for dvo in aws_acm_certificate.api_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.route53_zone.zone_id
}

# サブドメイン用ACMの検証
resource "aws_acm_certificate_validation" "api_acm_certificate_validation" {
  certificate_arn = aws_acm_certificate.api_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_route53_record : record.fqdn]
}


# ALB Aliasレコード （api.test-mm-sprint.com）
resource "aws_route53_record" "api_alias" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name = "api.${var.domain_name}"
  type = "A"

  alias {
    name = var.elb_dns_name
    zone_id = var.elb_zone_id
    evaluate_target_health = true
  }

  depends_on = [ 
    aws_acm_certificate_validation.api_acm_certificate_validation
  ]
}