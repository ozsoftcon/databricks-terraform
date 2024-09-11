variable "databricks_account_id" {
    type = string
}

variable "demo_prefix" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "cidr_block" {
    type = string
}

variable "workspace_host" {
    type = string
}

variable "region" {
    type = string
}