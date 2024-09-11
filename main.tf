
module "user_groups" {
    source = "./user_groups"

    databricks_account_id = var.databricks_account_id
    default_admin_users = var.default_admin_users
    default_service_principal = var.default_service_principal
    demo_prefix = var.demo_prefix
    
    
    providers = {
      aws = aws
      databricks = databricks.account
    }
}


module "cloud_resources" {

    source = "./cloud_resources"
    
    databricks_account_id = var.databricks_account_id
    demo_prefix = var.demo_prefix
    tags = var.tags
    cidr_block = var.cidr_block
    region = var.region
    workspace_host = var.workspace_host
    
    providers = {
      aws = aws
      databricks = databricks.account
    }
}



module "db_workspace" {
  
  source = "./workspace"

  databricks_account_id = var.databricks_account_id
  demo_prefix = var.demo_prefix
  tags = var.tags
  region = var.region
  workspace_name = var.workspace_name
  mws_credentials_id = module.cloud_resources.mws_credentials
  network_configuration_id = module.cloud_resources.mws_network_configuration
  storage_configuration_id = module.cloud_resources.mws_storage_configuration
  workspace_admin_group = module.user_groups.tf_group_id
  
  
  providers = {
    aws = aws
    databricks = databricks.account
  }

  depends_on = [module.cloud_resources]

  
}

module "db_workspace_jobs" {
  
  source = "./workspace_job"

  databricks_client_id = var.databricks_client_id
  databricks_service_principal = var.default_service_principal

  providers = {
    aws = aws
    databricks = databricks.demo_workspace
  }

  depends_on = [module.db_workspace]
  
}