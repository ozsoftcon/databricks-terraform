output "mws_credentials" {
    value = databricks_mws_credentials.this.credentials_id
}

output "mws_storage_configuration" {
    value = databricks_mws_storage_configurations.this.storage_configuration_id
}

output "mws_network_configuration" {
    value = databricks_mws_networks.this.network_id
}