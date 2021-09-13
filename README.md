# GCAT IAM Access Policies

This module creates any number if IAM Access Groups, and IAM Access Policies for those groups. It also allows users to invite users to the account and add them to any of the access groups created.

## Variables

Name             | Type                                                                                                                                                                                                                                                                                                               | Description                                                                  | Sensitive | Default
---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TF_VERSION       |                                                                                                                                                                                                                                                                                                                    | The version of the Terraform engine that's used in the Schematics workspace. |           | 1.0
ibmcloud_api_key | string                                                                                                                                                                                                                                                                                                             | The IBM Cloud platform API key needed to deploy IAM enabled resources        | true      | 
ibm_region       | string                                                                                                                                                                                                                                                                                                             | IBM Cloud region where all resources will be deployed                        |           | eu-de
access_groups    | See [access groups example](##access-groups-example) | A list of access groups to create                                            |           | See [access groups example](##access-groups-example)

## Access Groups Example

The flexible `access_groups` variable allows users to dynamically create groups with complex rules using a single object. This uses the expirimental `module_variable_optional_attrs` module to allow for optional variables in a typed object.

### Varable Type

```hcl
    list(
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
```

### Variable Default

```hcl
    [
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
```