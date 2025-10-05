output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.web_dist.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.web-mm-251004.bucket
}