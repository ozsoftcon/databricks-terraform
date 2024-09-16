terraform {
  backend "s3" {
    bucket         = "an-s3-bucket"
    key            = "databricks-terraform-demo"
    region         = "ap-southeast-2"
    dynamodb_table = "a-dynamo-table"
  }
}