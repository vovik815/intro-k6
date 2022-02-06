variable "computed_account_id" {
  description = "AWS Account ID"
}

variable "computed_env" {
  description = "Environment (dev, test, stage, prod)"
  default = "dev"
}

variable "computed_region" {
  description = "AWS Region"
}
