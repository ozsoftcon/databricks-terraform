data "databricks_user" "us" {
    for_each = toset(var.group.members)
    user_name = each.value
}
    
locals {

    user_emails = [for user in data.databricks_user.us: user.user_name]
    user_ids = [for user in data.databricks_user.us: user.id]
}

locals {
    matched_user = matchkeys(local.user_ids, local.user_emails, var.group.members)
}


resource "databricks_group" "tf_group" {
  provider                   = databricks
  display_name               = "${var.group.name}-${var.name_suffix}"
  allow_cluster_create       = var.group.allow_cluster_create
  allow_instance_pool_create = var.group.allow_instance_pool_create
  workspace_access           = true
}


resource "databricks_group_member" "users" {
    provider = databricks
    for_each = toset(local.matched_user)
    group_id  = databricks_group.tf_group.id
    member_id = each.value

    depends_on = [ databricks_group.tf_group ]
}

