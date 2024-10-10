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

variable "cidr_block" {
  type = string
}

variable "name_suffix" {
  type =string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-soutehast-2"
}

variable "default_admin_users" {
    type = list(string)
}

variable "default_service_principal"{
  type = string
}

