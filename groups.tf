
locals {
  account_requests = csvdecode(file("account-requests.csv"))
  account_names    = [for a in local.account_requests : a.name]
  accounts_resources = [for a in local.account_requests :
    { name   = a.name,
      OU     = a.ou,
      #costcenter = a.costcenter,
      groups = [for p in var.permission_sets : format("%s_%s_%s", var.azure_ad_group_prefix, a.name, p)],
    email = format("${var.account_email_prefix}${a.name}@${var.account_email_maildomain}") }
  ]
  groups = flatten([for a in local.accounts_resources : a.groups])
}

/*
data "azuread_application" "aws_sso_app" {
  display_name = var.aws_sso_azuread_app
}

resource "azuread_group" "aws_aad_groups" {
  for_each         = toset(local.groups)
  display_name     = each.key
  security_enabled = true
}

resource "azuread_app_role_assignment" "aws_sso_app_role_assignments" {
  for_each            = toset(local.groups)
  app_role_id         = var.aws_sso_azuread_app_roleid
  principal_object_id = azuread_group.aws_aad_groups[each.key].object_id
  resource_object_id  = var.aws_sso_azuread_resource_object_id
}
*/
