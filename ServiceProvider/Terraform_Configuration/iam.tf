resource "aws_iam_role" "lambdarole" {
  name = "lambdarole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "lambdapolicyy" {
  name = "lambdapolicyy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.s3_bucket.arn}/*"
      },
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = "arn:aws:iam::123456789012:role/scheduler_role"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambdarole.name
  policy_arn = aws_iam_policy.lambdapolicyy.arn
}
