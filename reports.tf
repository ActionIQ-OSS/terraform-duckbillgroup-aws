
# DuckbillGroupBilling AWS Cost and Usage Reports

resource "aws_cur_report_definition" "DuckbillGroup_cur_report" {
  count                      = var.duckbillgroup_cur_report_create ? 1 : 0
  report_name                = var.duckbillgroup_cur_report_name
  time_unit                  = "HOURLY"
  format                     = "Parquet"
  compression                = "Parquet"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = var.cur_bucket_name
  s3_prefix                  = "cur"
  s3_region                  = "us-east-1"
  additional_artifacts       = ["ATHENA"]
  report_versioning          = "OVERWRITE_REPORT"
}


# DuckbillGroupBilling S3 Bucket and Policy - AWS Cost and Usage Reports

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

