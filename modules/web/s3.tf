# s3バケット
resource "aws_s3_bucket" "web-mm-251004" {
  bucket = "${var.web_name_prefix}-mm-251004"

  tags = {
    Name = "${var.web_name_prefix}-mm-251004"
  }
}

# cloudfront専用アクセスポリシー
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "allow_cloudfront_only" {
  bucket = aws_s3_bucket.web-mm-251004.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = ["s3:GetObject"],
        Resource  = "${aws_s3_bucket.web-mm-251004.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.web_dist.arn
          }
        }
      }
    ]
  })
}