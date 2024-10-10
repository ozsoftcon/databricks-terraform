
module "user_groups" {
    source = "./default_admin_group"

    databricks_account_id = var.databricks_account_id
    default_admin_users = var.default_admin_users
    default_service_principal = var.default_service_principal
    name_suffix = var.name_suffix
    
    
    providers = {
      aws = aws
      databricks = databricks.account
    }
}

## Creating groups at the account level
## we can replicate this for any new group
## or editing existing group

module "db_account_group_cost_control" {
  
  source = "./account_groups"

  group = {
    name = "Group Name"
    members = [
      "member@email.com"
    ]
    allow_cluster_create = true
    allow_instance_pool_create = true
  }
  name_suffix = var.name_suffix
  providers = {
    aws = aws
    databricks = databricks.account
  }
  
}

module "cloud_resources" {

    source = "./cloud_resources"
    
    databricks_account_id = var.databricks_account_id
    name_suffix = var.name_suffix
    tags = var.tags
    cidr_block = var.cidr_block
    region = var.region
    
    providers = {
      aws = aws
      databricks = databricks.account
    }
}

module "metastore" {
    source = "./unity_catalogue"

    region = var.region
    name_suffix = var.name_suffix
    metastore_admin_group_id = module.user_groups.tf_group_id

    providers = {
      aws = aws
      databricks = databricks.account
    }

    depends_on = [ module.user_groups ]

}