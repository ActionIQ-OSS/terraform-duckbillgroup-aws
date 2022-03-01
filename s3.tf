resource "aws_s3_bucket" "cost_and_usage_bucket" {
  count  = var.cur_bucket_name_create ? 1 : 0
  bucket = var.cur_bucket_name

  tags = {
    Name = var.cur_bucket_name
  }
}

resource "aws_s3_bucket_policy" "cost_and_usage_bucket_policy" {
  bucket = aws_s3_bucket.cost_and_usage_bucket[0].id
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "Policy1335892530063",
    "Statement" : [
      {
        "Sid" : "Stmt1335892150622",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "billingreports.amazonaws.com"
        },
        "Action" : [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy"
        ],
        "Resource" : aws_s3_bucket.cost_and_usage_bucket[0].arn,
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : var.aws_master_billing_account,
            "aws:SourceArn" : "arn:aws:cur:us-east-1:${var.aws_master_billing_account}:definition/*"
          }
        }
      },
      {
        "Sid" : "Stmt1335892526596",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "billingreports.amazonaws.com"
        },
        "Action" : "s3:PutObject",
        "Resource" : "${aws_s3_bucket.cost_and_usage_bucket[0].arn}/*",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : var.aws_master_billing_account,
            "aws:SourceArn" : "arn:aws:cur:us-east-1:${var.aws_master_billing_account}:definition/*"
          }
        }
      }
    ]
  })
}

