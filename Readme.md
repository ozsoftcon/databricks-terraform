## Deploying workspace in Databricks using Terraform

### Prerequisites

1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

NOTE: Make sure the terrafor executables are in your `PATH`.

### Running Locally

#### Preparing ENV

```bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export TF_VAR_databricks_account_id=
export TF_VAR_databricks_client_id=
export TF_VAR_databricks_client_secret=
```

Explanation:

1. `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are the corresponding secret access keys associated with `terraform-user` from AWS account.
2. `TF_VAR_databricks_client_id` and `TF_VAR_databricks_client_secret` are the `application_id` and `secret` of `terraform-databricks` Service Principal from Databricks account.
3. `TF_VAR_databricks_account_id` is the account id (see [here](https://docs.databricks.com/en/admin/account-settings/index.html#locate-your-account-id))

These values are stored in Secrets Manager `bitbucket-pipeline-variables`.

NOTE: `TF_VAR_databricks_client_secret` may need to be updated at regular interval.

#### Run the terraform cli

- To Preview the changes

```bash
$ cd <account or workspace>
$ terraform init
$ terraform plan --var-file=values.tfvars
```

- To Apply the changes

```bash
$ cd <account or workspace>
$ terraform init
$ terraform apply --var-file=values.tfvars
```

- To Destroy the resources

```bash
$ cd <account or workspace>
$ terraform init
$ terraform destroy --var-file=values.tfvars
```

NOTE: You can run the commands without `-auto-approve` - in that case it will ask for a confirmation interactively on CLI.

### Running the Bitbucket pipeline

- To Preview the changes

    - Choose `Pipeline->Run Pipeline`
    - Choose branch (e.g. `main`) and `custom: preview_demo_deployment` in the dialogue box
    - Click `Run`

- To Apply the changes

    - Choose `Pipeline->Run Pipeline`
    - Choose branch (e.g. `main`) and `custom: deploy_demo_workspace` in the dialogue box
    - Click `Run`

- To Destroy the changes

    - Choose `Pipeline->Run Pipeline`
    - Choose branch (e.g. `main`) and `custom: destroy_demo_deployment` in the dialogue box
    - Click `Run`
