variable "group"{
    type = object({
        name = string
        members = list(string)
        allow_cluster_create = bool
        allow_instance_pool_create = bool
    })
}

variable "name_suffix" {
    type = string
}
