
terraform {
  required_version = ">= 1.8.5, <= 1.9.5"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}


// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  host          = "https://accounts.cloud.databricks.com"
  account_id    = var.databricks_account_id
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
  alias         = "account"
}

// initialize provider in "MWS" mode for a new workspace
provider "databricks" {
  host          = "https://${var.WORKSPACE}.cloud.databricks.com"
  client_id     = var.databricks_client_id
  client_secret = var.databricks_client_secret
  alias         = "demo_workspace"
}