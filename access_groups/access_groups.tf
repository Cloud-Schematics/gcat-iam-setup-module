##############################################################################
# Local Variables
##############################################################################

locals { 
    # Convert access groups from list into object
    access_groups_object = {
        for group in var.access_groups:
        (group.name) => group
    }

    # Add all policies to a single list
    access_policy_list = flatten([
        # For each group
        for group in var.access_groups: [
            # Add policy object to array
            for policy in group.policies:
            # Add `group` field to object
            merge(policy, {group: group.name})
        ]
    ])

    # Convert access policy list into object
    access_policies = {
        for item in local.access_policy_list:
        (item.name) => item
    }

    # Get a list of all resource groups from access groups
    resource_groups = distinct(
        flatten([ 
            # For each group
            for group in var.access_groups: [
                # For each policy
                for policy in group.policies:
                # if the policy contains a resource group return it
                policy.resources.resource_group if contains(keys(policy.resources), "resource_group")
            ]
        ])
    )
}

##############################################################################


##############################################################################
# Create IAM Access Groups
##############################################################################

resource ibm_iam_access_group groups {
    for_each    = local.access_groups_object
    name        = each.key
    description = each.value.description
}

##############################################################################


##############################################################################
# Resource Groups for IAM Policies
##############################################################################

data ibm_resource_group resource_group {
    for_each = toset(local.resource_groups)
    name     = each.value   
}

##############################################################################


##############################################################################
# Create Access Group Policies
##############################################################################

resource ibm_iam_access_group_policy policies {
    for_each        = local.access_policies
    access_group_id = ibm_iam_access_group.groups[each.value.group].id
    roles           = each.value.roles
    resources {
        # Resources are made variable so that each policy can be specific without needing to use multiple blocks
        resource_group_id    = contains(keys(each.value.resources), "resource_group") ? data.ibm_resource_group.resource_group[each.value.resources.resource_group].id : null
        resource_type        = contains(keys(each.value.resources), "resource_type") ? each.value.resources.resource_type : null
        service              = contains(keys(each.value.resources), "service") ? each.value.resources.service : null
        resource_instance_id = contains(keys(each.value.resources), "resource_instance_id") ? each.value.resources.resource_instance_id : null
        attributes           = contains(keys(each.value.resources), "attributes") ? each.value.resources.attributes : null
    }
}

##############################################################################