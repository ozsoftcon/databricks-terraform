output "demo_databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "demon_databricks_id" {
  value = databricks_mws_workspaces.this.id
}
