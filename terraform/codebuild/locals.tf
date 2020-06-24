locals {
  service_name = "apollo-load-test"
  tags = {
    Name        = "${var.computed_account_id}-${local.service_name}"
    Application = local.service_name
    Environment = var.computed_env
    GitRepo     = "github.com/getndazn/${local.service_name}"
    ManagedBy   = "Terraform"
    Owner       = "apollo@dazn.com"
  }
}
