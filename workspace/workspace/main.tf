data "databricks_metastore" "this" {
    name = "demo-metastore-${var.name_suffix}" #"databricks-metastore-unity-catalog"
    provider = databricks
}

data "databricks_group" "default_admins" {
  provider = databricks
  display_name = "demo-group-${var.name_suffix}"
}

data "aws_iam_role" "cross_account_role" {
  name = "demo-role-crossaccount-${var.name_suffix}"
}

data "aws_s3_bucket" "root_storage_bucket" {
  bucket = "demo-rootbucket-${var.name_suffix}"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["demo-vpc-${var.name_suffix}"]
  }
}

data "aws_security_group" "security_group" {
  #name = "demo-sg-${var.name_suffix}"
  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnets" "subnets" {
  filter {
    name = "tag:Name"
    values = ["demo-vpc-${var.name_suffix}-private-*"]
  }
}

resource "databricks_mws_credentials" "this" {
  provider         = databricks
  role_arn         = data.aws_iam_role.cross_account_role.arn
  credentials_name = "demo-creds-${var.name_suffix}"
}


resource "databricks_mws_storage_configurations" "this" {
  provider                   = databricks
  account_id                 = var.databricks_account_id
  bucket_name                = data.aws_s3_bucket.root_storage_bucket.bucket
  storage_configuration_name = "demo-storage-${var.name_suffix}"
}


resource "databricks_mws_networks" "this" {
  provider           = databricks
  account_id         = var.databricks_account_id
  network_name       = "demo-network-${var.name_suffix}"
  security_group_ids = [data.aws_security_group.security_group.id]
  subnet_ids         = data.aws_subnets.subnets.ids # module.vpc.private_subnets
  vpc_id             = data.aws_vpc.vpc.id #module.vpc.vpc_id
}

resource "databricks_mws_workspaces" "this" {
  provider       = databricks
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = var.workspace_name

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id

  custom_tags = var.tags

}

resource "time_sleep" "wait_workspace_create" {
  depends_on = [
    databricks_mws_workspaces.this
  ]
  create_duration = "2m"
}

resource "databricks_metastore_assignment" "default" {
    provider = databricks
    workspace_id = databricks_mws_workspaces.this.workspace_id
    metastore_id = data.databricks_metastore.this.metastore_id
}

resource "time_sleep" "wait_metastore_assignment" {
  depends_on = [
    databricks_metastore_assignment.default
  ]
  create_duration = "2m"
}

resource "databricks_mws_permission_assignment" "add_admin_group" {
  provider = databricks
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = data.databricks_group.default_admins.id
  permissions  = ["ADMIN"]
  depends_on = [time_sleep.wait_metastore_assignment]
}

