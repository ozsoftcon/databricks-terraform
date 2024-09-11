
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