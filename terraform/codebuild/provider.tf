provider "aws" {
  region = var.computed_region
}

provider "template" {
    version = "~> 2.1"
}
