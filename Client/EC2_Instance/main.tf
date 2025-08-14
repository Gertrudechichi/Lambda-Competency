data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create an EC2 instance
resource "aws_instance" "instance1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  tags = {
    Name = "instance1"
  }
}

# This is a role with permissions to start and stop EC2 instances.
# The Lambda function role will assume this role so that it can do that
resource "aws_iam_role" "scheduler_role" {
  name        = "scheduler_role"
  description = "Role for EC2 scheduler"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::xxxxxxxxxxxx:role/lambdarole" 
        }
      }
    ]
  })
}

# Policy for EC2 scheduler
resource "aws_iam_policy" "schedulerinstance" {
  name        = "schedulerinstance"
  description = "Policy for EC2 scheduler"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances"
        ]
        Resource = "*"
        Effect    = "Allow"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "policyattachment" {
  role       = aws_iam_role.scheduler_role.name
  policy_arn = aws_iam_policy.schedulerinstance.arn
}


