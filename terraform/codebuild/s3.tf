resource "aws_s3_bucket" "apollo_load_test_reports" {
    bucket = "${var.computed_account_id}-${local.service_name}-reports-${var.computed_region}"
    acl = "private"
    tags = local.tags
}
