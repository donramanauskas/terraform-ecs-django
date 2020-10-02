provider "aws" {
  version             = "= 2.70.0"
  region              = var.region
  allowed_account_ids = var.allowed_accounts
}