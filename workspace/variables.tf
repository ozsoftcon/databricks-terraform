variable "databricks_account_id" {
  type = string
}

variable "databricks_client_id" {
  type = string
}

variable "databricks_client_secret" {
  type = string
}

variable "tags" {
  type = map
}

variable "name_suffix" {
  type =string
}

variable "workspace_host" {
  description = "Databricks Workspace Host URL"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-soutehast-2"
}

variable "workspace_name" {
  type = string
}

variable "WORKSPACE" {
  type = string
  default = ""
}


