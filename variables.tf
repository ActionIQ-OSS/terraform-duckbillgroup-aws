variable "region" {
  type    = string
  default = "us-east-1"
}

variable "duckbillgroup_aws_account" {
  type    = number
  default = "753095100886"
}
variable "customer_name_slug" {
  type        = string
  description = "A short, lower-case slug that identifies your company, e.g. 'acme-corp'. Duckbill Group will need to know this value, so that we can set up our own infrastructure for you."
}

variable "cur_bucket_name" {
  type        = string
  description = "Name of the S3 bucket in which you are storing Cost and Usage Reports."
}

variable "external_id" {
  type        = string
  description = "Customer Specific External ID string"
}

variable "cur_bucket_name_create" {
  type        = bool
  description = "Set this true when calling the module if you desire bucket to be created"
  default     = false
}

variable "duckbillgroup_cur_report_name" {
  type        = string
  description = "Name of AWS Cost and Usage report"
  default     = "SpendReport_Athena"
}

variable "duckbillgroup_cur_report_create" {
  type        = bool
  description = "Set this true when calling the module if you desire report to be created"
  default     = false
}

variable "aws_master_billing_account" {
  type        = number
  description = "AWS account number where billing is consolidated."
}
