Name             | Type                                                                                                                                                                                                                                                                                   | Description                                                                  | Sensitive | Default
---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TF_VERSION       |                                                                                                                                                                                                                                                                                        | The version of the Terraform engine that's used in the Schematics workspace. |           | 1.0
ibmcloud_api_key | string                                                                                                                                                                                                                                                                                 | The IBM Cloud platform API key needed to deploy IAM enabled resources        | true      | 
ibm_region       | string                                                                                                                                                                                                                                                                                 | IBM Cloud region where all resources will be deployed                        |           | eu-de
access_groups    | list( object({ name = string description = string policies = list( object({ name = string roles = list(string) resources = object({ resource_group = optional(string) resource_type = optional(string) service = optional(string) resource_instance_id = optional(string) }) }) ) }) ) | A list of access groups to create                                            |           | [<br>{<br>name = "admin"<br>description = "An<br>example admin group" policies = [<br>{<br>name = "admin_all"<br>resources = {<br>resource_group = "asset-development"<br>}<br>roles = ["Administrator","Manager"]<br>},<br>{<br>name = "admin_service"<br>resources = {<br>service = "cloud-object-storage"<br>resource_group = "asset-development"<br>}<br>roles = ["Content<br>Reader"]<br>},<br>{<br>name = "admin_rg"<br>resources = {<br>resource_group = "asset-development"<br>resource_type = "resource-group"<br>}<br>roles = ["Editor","Manager"]<br>},<br>]<br>},<br>{<br>name = "admin_default"<br>description = "An<br>example admin group" policies = [<br>{<br>name = "admin_default_all"<br>resources = {<br>resource_group = "default"<br>}<br>roles = ["Administrator","Manager"]<br>},<br>{<br>name = "admin_default_ervice"<br>resources = {<br>service = "cloud-object-storage"<br>resource_group = "default"<br>}<br>roles = ["Content<br>Reader"]<br>},<br>{<br>name = "admin_default_rg"<br>resources = {<br>resource_group = "default"<br>resource_type = "resource-group"<br>}<br>roles = ["Editor","Manager"]<br>},<br>]<br>}<br>]
