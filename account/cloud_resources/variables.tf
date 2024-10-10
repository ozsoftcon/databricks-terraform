variable "databricks_account_id" {
    type = string
}

variable "name_suffix" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "cidr_block" {
    type = string
}

variable "region" {
    type = string
}