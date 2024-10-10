module "db_workspace" {
  
  source = "./workspace"

  databricks_account_id = var.databricks_account_id
  name_suffix = var.name_suffix
  tags = var.tags
  region = var.region
  workspace_name = var.workspace_name
  
  
  providers = {
    aws = aws
    databricks = databricks.account
  }
  
}

# module "db_workspace_jobs" {
  
#   source = "./workspace_job"

#   databricks_client_id = var.databricks_client_id
#   databricks_service_principal = var.default_service_principal

#   providers = {
#     aws = aws
#     databricks = databricks.demo_workspace
#   }

#   depends_on = [module.db_workspace]
  
# }