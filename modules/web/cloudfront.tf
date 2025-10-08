provider "aws" {
  alias = "global"
  region = "us-east-1"
}

# CloudFront + Distribution
resource "aws_cloudfront_origin_access_control" "web_oac" {
  name = "${var.web_name_prefix}-oac"
  description = "Origin Access Control for web-mm CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

resource "aws_cloudfront_distribution" "web_dist" {
  provider = aws.global
  enabled = true
  is_ipv6_enabled = true
  comment = "CloudFront distribution for static site web-mm-251004"
  default_root_object = "index.html"
  aliases = [var.domain_name]

  # origin {
  #   domain_name = aws_s3_bucket.web-mm-251004.bucket_regional_domain_name
  #   origin_id = "s3-web-origin"
  #   origin_access_control_id = aws_cloudfront_origin_access_control.web_oac.id
  # }
  origin {
    domain_name = "api.${var.domain_name}"
    origin_id = "alb-api-origin"
    custom_origin_config {
      origin_protocol_policy = "https-only"
      http_port = 80
      https_port = 443
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  # default_cache_behavior {
  #   target_origin_id       = "s3-web-origin"
  #   viewer_protocol_policy = "redirect-to-https"
  #   allowed_methods        = ["GET", "HEAD"]
  #   cached_methods         = ["GET", "HEAD"]

  #   forwarded_values {
  #     query_string = false
  #     cookies {
  #       forward = "none"
  #     }
  #   }
  # }
  default_cache_behavior {
    target_origin_id = "alb-api-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      headers = ["Origin", "Authorization", "Host"]
      cookies {
        forward = "all"
      }
    }

    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "${var.web_name_prefix}-cloudfront"
  }
}