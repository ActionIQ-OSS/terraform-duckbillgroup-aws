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
