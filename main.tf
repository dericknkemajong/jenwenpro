
    resource "aws_iam_role" "IAM_Role" {
  name = "IAM_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_instance" "jenwen_instance" {
  ami           = "ami-0ed9277fb7eb570c9" # us-east-1
  instance_type = "t2.micro"
}
resource "aws_iam_instance_profile" "instance_profile" {
  name = "jenwen_profile"
  role = aws_iam_role.IAM_Role.name
}



resource "aws_iam_role_policy" "role_policy" {
  name = "role_policy"
  role = aws_iam_role.IAM_Role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1639609530815",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::glorykey"
    },
    {
      "Sid": "Stmt1639609660904",
      "Action": [
       "dynamodb:GetItem"

      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
  )
}
