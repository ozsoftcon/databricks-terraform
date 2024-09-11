variable "databricks_account_id" {
    type = string
}

variable "default_admin_users" {
    type = list(string)
}

variable "default_service_principal"{
  type = string
}

variable "demo_prefix" {
    type = string
}
