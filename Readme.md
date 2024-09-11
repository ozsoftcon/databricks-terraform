## Deploying workspace in Databricks

### Prerequisites

1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

NOTE: Make sure the terrafor executables are in your `PATH`.

### Running Locally

#### Preparing ENV

```bash
$ export AWS_ACCESS_KEY_ID=
$ export AWS_SECRET_ACCESS_KEY=
$ export DATABRICKS_CLIENT_ID=
$ export DATABRICKS_CLIENT_SECRET=
$ export TF_VAR_databricks_account_id=
$ export TF_VAR_databricks_client_id=
```

Explanation:

1. `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are the corresponding secret access keys associated with `terraform-user` from AWS account.
2. `DATABRICKS_CLIENT_ID` and `DATABRICKS_CLIENT_SECRET` are the `application_id` and `secret` of `terraform-databricks` Service Principal from Databricks account.
3. `TF_VAR_databricks_account_id` is the account id (see [here](https://docs.databricks.com/en/admin/account-settings/index.html#locate-your-account-id))
4. `TF_VAR_databricks_client_id` is the same as `DATABRICKS_CLIENT_ID`

These values are stored in Secrets Manager `bitbucket-pipeline-variables`.

NOTE: `DATABRICKS_CLIENT_SECRET` may need to be updated at regular interval.

#### Run the terraform cli

- To Preview the changes

```bash
$ cd demo_workspace
$ terraform init --upgrade
$ terraform plan --var-file=values.tfvars
```

- To Apply the changes

```bash
$ cd demo_workspace
$ terraform init --upgrade
$ terraform apply --var-file=values.tfvars -auto-approve
```

- To Destroy the resources

```bash
$ cd demo_workspace
$ terraform init --upgrade
$ terraform destroy --var-file=values.tfvars -auto-approve
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
