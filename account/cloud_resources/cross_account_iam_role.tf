data "databricks_aws_assume_role_policy" "this" {
  provider    = databricks
  external_id = var.databricks_account_id
}

resource "time_sleep" "wait" {
  depends_on = [
    aws_iam_role.cross_account_role
  ]
  create_duration = "20s"
}

resource "aws_iam_role" "cross_account_role" {
  name               = "demo-role-crossaccount-${var.name_suffix}"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

data "databricks_aws_crossaccount_policy" "this" {
  provider    = databricks
  # policy_type = "customer"
}

resource "aws_iam_role_policy" "this" {
  name   = "demo-policy-${var.name_suffix}"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
  # provider = databricks
}
