tags = {
    app = "databricks-demo"
}
cidr_block = "10.150.0.0/16"
region = "ap-southeast-2"
demo_prefix = "databricks-terraform-demo"
workspace_host = "https://accounts.cloud.databricks.com"
workspace_name = "terraform-demo"

default_admin_users = ["someadmin@email.com"]
default_service_principal = "client-id-of-some-service-principal"
