# *Unofficial* DuckBill Group AWS Onboarding Module

Terraform module which creates necessary resources for [The DuckBill Group](https://www.duckbillgroup.com/) to do the magic (scoped), all over your account.

Inspired by: https://github.com/DuckbillGroup/onboarding/

## Usage

```
module "theduckbillgroup" {
  source = "terraform-duckbillgroup-aws"

  customer_name_slug = "horrifyingbills-please-help"
  cur_bucket_name = "example-cost-and-usage-reports-bucket-name"
  external_id = "012345678-0123-01234-01234-012345678923"
  cur_bucket_name_create = true
  duckbillgroup_cur_report_create = true
  aws_master_billing_account = "012345678901"

}
```

## Authors

Module is maintained by [John Favorite](https://github.com/OldCrowEW) [@ActionIQ](https://www.actioniq.com/) with help from [these awesome engineers](https://github.com/ActionIQ).