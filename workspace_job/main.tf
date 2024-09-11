resource "databricks_job" "test" {
  name        = "A simple test job with one task"
  description = "This job a sample tasks on a job compute cluster"

  job_cluster {
    job_cluster_key = "Job_cluster"
    new_cluster {
        spark_version = "15.4.x-scala2.12"
        aws_attributes {
          first_on_demand = 1
          availability = "SPOT_WITH_FALLBACK"
          zone_id = "auto"
          spot_bid_price_percent = 100
        }
        node_type_id = "m5d.large"
        enable_elastic_disk = true
        # policy_id = "001BB9B8047EA19F"
        data_security_mode = "SINGLE_USER"
        runtime_engine = "STANDARD"
        autoscale {
          min_workers = 1
          max_workers = 2
        }
    }
  }

  task {
    task_key = "task_one"

    new_cluster {
        spark_version = "15.4.x-scala2.12"
        aws_attributes {
          first_on_demand = 1
          availability = "SPOT_WITH_FALLBACK"
          zone_id = "auto"
          spot_bid_price_percent = 100
        }
        node_type_id = "m5d.large"
        enable_elastic_disk = true
        # policy_id = "001BB9B8047EA19F"
        data_security_mode = "SINGLE_USER"
        runtime_engine = "STANDARD"
        autoscale {
          min_workers = 1
          max_workers = 2
        }
    }

    notebook_task {
      notebook_path = "/Workspace/Shared/sample_repo/sample_notebook"
    }
  }

  run_as {
    service_principal_name = var.databricks_client_id
  }


  max_concurrent_runs = 1

  provider = databricks
}

resource "databricks_permissions" "job_usage" {
  job_id = databricks_job.test.id

  # access_control {
  #   group_name       = "users"
  #   permission_level = "CAN_VIEW"
  # }

  # access_control {
  #   group_name       = databricks_group.auto.display_name
  #   permission_level = "CAN_MANAGE_RUN"
  # }

  # access_control {
  #   group_name       = databricks_group.eng.display_name
  #   permission_level = "CAN_MANAGE"
  # }

  access_control {
    service_principal_name = var.databricks_service_principal
    permission_level       = "IS_OWNER"
  }

  provider = databricks
}
