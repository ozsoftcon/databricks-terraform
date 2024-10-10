
terraform {
  required_version = ">= 1.8.5, <= 1.9.6"

  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
    aws = {
      source  = "hashicorp/aws"
    }
  }
}