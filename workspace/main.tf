data "databricks_metastore" "this" {
    name = "databricks-metastore-unity-catalog"
    provider = databricks
}

resource "databricks_mws_workspaces" "this" {
  provider       = databricks
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = var.workspace_name

  credentials_id           = var.mws_credentials_id
  storage_configuration_id = var.storage_configuration_id
  network_id               = var.network_configuration_id

  custom_tags = var.tags

}

resource "databricks_metastore_assignment" "default" {
    provider = databricks
    workspace_id = databricks_mws_workspaces.this.workspace_id
    metastore_id = data.databricks_metastore.this.metastore_id
}

resource "time_sleep" "wait" {
  depends_on = [
    databricks_metastore_assignment.default
  ]
  create_duration = "1m"
}

resource "databricks_mws_permission_assignment" "add_admin_group" {
  provider = databricks
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = var.workspace_admin_group
  permissions  = ["ADMIN"]
}