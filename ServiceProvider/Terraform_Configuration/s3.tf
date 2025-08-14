variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "lambda_zip_file_path" {
  type        = string
  description = "The path to the lambda.zip file"
}

variable "aws_region" {
  type        = string
  description = "The AWS region"
  default     = "us-east-1"
}

# S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}


# S3 Bucket Policy
data "aws_iam_policy_document" "allow_access" {
  statement {
    sid = "AllowLambdaAccess"
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.lambdarole.arn] 
    }
    actions = [ 
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn,
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "bucketPolicy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.allow_access.json
}

# Upload Lambda ZIP file to S3
resource "aws_s3_object" "lambda_zip_file" {
  bucket = aws_s3_bucket.s3_bucket.id
  key    = "lambda.zip"
  source = var.lambda_zip_file_path
  etag   = filemd5(var.lambda_zip_file_path)
}
