terraform {
  backend "s3" {
    bucket         = "besix-databricks-terraform-ap-southeast-2"
    key            = "databricks-terraform-demo"
    region         = "ap-southeast-2"
    dynamodb_table = "besix-databricks-terraform-ap-southeast-2"
  }
}