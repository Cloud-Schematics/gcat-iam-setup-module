##############################################################################
# Account Variables
##############################################################################

variable TF_VERSION {
    default     = "1.0"
    description = "The version of the Terraform engine that's used in the Schematics workspace."
}

variable ibmcloud_api_key {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
    type        = string
    sensitive   = true
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
    default     = "eu-de"

    validation  {
      error_message = "Must use an IBM Cloud region. Use `ibmcloud regions` with the IBM Cloud CLI to see valid regions."
      condition     = can(
        contains(
            ["au-syd", "br-sao", "ca-tor", "jp-tok", "jp-osa", "eu-de", "eu-gb", "us-south", "us-east"], 
            var.ibm_region
        )
      )
    }
}

##############################################################################


##############################################################################
# Access Group Rules
##############################################################################

variable access_groups {
    description = "A list of access groups to create"
    type        = list(
        object({
            name        = string # Name of the group
            description = string # Description of group
            policies    = list(
                object({
                    name      = string       # Name of the policy
                    roles     = list(string) # list of roles for the policy
                    resources = object({
                        resource_group       = optional(string) # Name of the resource group the policy will apply to
                        resource_type        = optional(string) # Name of the resource type for the policy ex. "resource-group"
                        service              = optional(string) # Name of the service type for the policy ex. "cloud-object-storage"
                        resource_instance_id = optional(string) # ID of a service instance to give permissions
                    })
                })
            )
            invite_users = list(string) # Users to invite to the access group
        })
    )
    default     = [
        {
            name        = "admin"
            description = "An example admin group"
            policies    = [
                {
                    name = "admin_all"
                    resources = {
                        resource_group = "asset-development"
                    }
                    roles = ["Administrator","Manager"]
                },
                {
                    name = "admin_service"
                    resources = {
                        service = "cloud-object-storage"
                        resource_group = "asset-development"
                    }
                    roles = ["Content Reader"]
                },
                {
                    name = "admin_rg"
                    resources = {
                        resource_group = "asset-development"
                        resource_type  = "resource-group" 
                    }
                    roles = ["Editor","Manager"]
                },
            ]
            invite_users = [ "test@test.test" ]
        },
        {
            name        = "admin_default"
            description = "An example admin group"
            policies    = [
                {
                    name = "admin_default_all"
                    resources = {
                        resource_group = "default"
                    }
                    roles = ["Administrator","Manager"]
                },
                {
                    name = "admin_default_ervice"
                    resources = {
                        service = "cloud-object-storage"
                        resource_group = "default"
                    }
                    roles = ["Content Reader"]
                },
                {
                    name = "admin_default_rg"
                    resources = {
                        resource_group = "default"
                        resource_type  = "resource-group" 
                    }
                    roles = ["Editor","Manager"]
                },
            ]
            invite_users = [ "test@test.test" ]
        }
    ]
}

##############################################################################