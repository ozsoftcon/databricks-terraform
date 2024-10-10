data databricks_group "default_admins" {
    display_name = "demo-group-${var.name_suffix}"
}

resource "databricks_metastore" "this" {
  provider      = databricks
  name          = "demo-metastore-${var.name_suffix}"
  storage_root  = "s3://${aws_s3_bucket.metastore.id}/metastore"
  owner         = data.databricks_group.default_admins.display_name
  region        = var.region
  force_destroy = true
}


resource "aws_s3_bucket" "metastore" {
  bucket = "demo-uc-external-${var.name_suffix}"
  // destroy all objects with bucket destroy
  force_destroy = true
  tags = merge({
    Name = "demo-external-${var.name_suffix}"
  })
}

resource "aws_s3_bucket_versioning" "external_versioning" {
  bucket = aws_s3_bucket.metastore.id
  versioning_configuration {
    status = "Disabled"
  }
}

