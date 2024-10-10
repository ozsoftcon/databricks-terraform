terraform {
  backend "s3" {
    bucket         = "<an-s3-bucket-name>"
    key            = "<a-key-within-the-bucket>"
    region         = "<region-of-the-backend>"
    dynamodb_table = "<a-dynamo-table>"
  }
}