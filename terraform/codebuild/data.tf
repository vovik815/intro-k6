data "aws_caller_identity" "current" {}

data "template_file" "codebuild_policy" {
  template = templatefile(
    "${path.module}/templates/codebuild-policy.json",
    {
      aws_region              = var.computed_region
      aws_profile             = data.aws_caller_identity.current.account_id
      codebuild_project_name  = local.service_name
      reports_bucket          = aws_s3_bucket.apollo_load_test_reports.arn
    }
  )
}

data "template_file" "buildspec_k6" {
  template = templatefile("${path.module}/templates/buildspec-k6.yml", {})
}