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