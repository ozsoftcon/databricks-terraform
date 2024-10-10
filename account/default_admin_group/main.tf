data "databricks_user" "tf_admin_users" {
    for_each = toset(var.default_admin_users)
    user_name = each.key
    provider = databricks
}

data "databricks_service_principal" "tf_service_principal"{
    provider = databricks
    application_id = var.default_service_principal
}

locals {
    admin_user_ids = toset([for z in data.databricks_user.tf_admin_users : z.id])
}

resource "databricks_group" "tf_admin_group" {
  provider                   = databricks
  display_name               = "demo-group-${var.name_suffix}"
  allow_cluster_create       = true
  allow_instance_pool_create = true
  workspace_access           = true
}

resource "databricks_group_member" "users" {
    provider = databricks
    for_each = toset(local.admin_user_ids)
    group_id  = databricks_group.tf_admin_group.id
    member_id = each.value
}

resource "databricks_group_member" "service_principal" {
   provider = databricks
   group_id  = databricks_group.tf_admin_group.id
   member_id = data.databricks_service_principal.tf_service_principal.id
}

resource "databricks_group_role" "tf_admin_group_role" {
  group_id = databricks_group.tf_admin_group.id
  role     = "account_admin"
}
