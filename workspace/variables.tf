variable "databricks_account_id" {
    type = string
}

variable "region" {
    type = string
}

variable "demo_prefix" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "workspace_name" {
    type = string
}

variable "mws_credentials_id" {
    type = string
}

variable "storage_configuration_id" {
    type = string
}

variable "network_configuration_id" {
    type = string
}

variable "workspace_admin_group" {
    type = string
}
