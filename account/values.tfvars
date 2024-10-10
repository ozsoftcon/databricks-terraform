tags = {
    app = "databricks-demo"
}
cidr_block = "10.150.0.0/16" # change it if you require
region = "<region-for-the-resources>"
name_suffix = "tf-ap1"

default_admin_users = ["account_admin@email.com"]
default_service_principal = "<a-service-principal-app_id-with-account-admin-permission>"

