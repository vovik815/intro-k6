terraform {
  required_version = ">= 0.12.11"
  backend "s3" {
    region = "eu-central-1"
  }
}

resource "aws_codebuild_project" "load_test_runner" {
  name          = local.service_name
  description   = "Run load tests versus the given environment"
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type      = "S3"
    location  = aws_s3_bucket.apollo_load_test_reports.bucket
  }

  logs_config {
    s3_logs {
      status = "ENABLED"
      location = "${aws_s3_bucket.apollo_load_test_reports.bucket}/build-log"
    }
  }

  environment {
      compute_type      = var.compute_type
      image             = "loadimpact/k6"
      type              = "LINUX_CONTAINER"
      image_pull_credentials_type = "SERVICE_ROLE"

      privileged_mode   = true

      environment_variable {
        name  = "TARGET_ENV"
        value = var.target_env
      }
      environment_variable {
          name = "TARGET_SERVICE"
          value = "lp-content-proxy"
      }
      environment_variable{
          name = "TEST_TYPE"
          value = var.test_type
      }
      environment_variable {
          name = "MAX_USERS"
          value = var.max_users
      }
      environment_variable {
          name = "LOAD_DURATION"
          value = var.load_duration
      }
      environment_variable {
          name = "USER_THINK_TIME"
          value = var.user_think_time
      }
      environment_variable {
          name = "RAMP_UP_DURATION"
          value = var.ramp_up_duration
      }
      environment_variable {
          name = "RAMP_DOWN_DURATION"
          value = var.ramp_down_duration
      }
  }
   source {
    type            = "GITHUB"
    location        = var.source_location

    git_clone_depth = 1
    buildspec       = data.template_file.buildspec_k6.rendered
  }

   source_version = var.source_version

   tags = local.tags
}

resource "aws_iam_role" "codebuild_role" {
  name        = "codebuild-${local.service_name}-${var.computed_region}"
  description = "Codebuild role for the ${local.service_name} tasks."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = local.tags
}

resource "aws_iam_role_policy" "codebuild_role_policy" {
  role   = aws_iam_role.codebuild_role.name
  policy = data.template_file.codebuild_policy.rendered
}
