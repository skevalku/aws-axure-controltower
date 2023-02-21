resource "aws_servicecatalog_provisioned_product" "accounts" {
  for_each                 = { for account in local.accounts_resources : account.name => account }
  name                     = each.value.name
  product_id               = var.aws_ct_account_factory_product_id
  provisioning_artifact_id = "pa-4tozzdhl2byuk"

  provisioning_parameters {
    key   = "SSOUserEmail"
    value = var.account_sso_email
  }
  provisioning_parameters {
    key   = "AccountEmail"
    value = each.value.email
  }
  provisioning_parameters {
    key   = "AccountName"
    value = each.value.name
  }
  provisioning_parameters {
    key   = "ManagedOrganizationalUnit"
    value = var.ou_mapping_table[each.value.OU]
  }
  provisioning_parameters {
    key   = "SSOUserLastName"
    value = var.account_sso_name
  }
  provisioning_parameters {
    key   = "SSOUserFirstName"
    value = var.account_sso_name
  }


  tags = {
    Testby = "Keval"
    TFmanaged  = "True"
  }

  timeouts {
    create = "60m"
    delete = "30m"
    update = "30m"
    read   = "30m"
  }
  ignore_errors = "true"
}

resource "aws_ce_cost_category" "test2" {
name = "Newtes"
rule_version = "CostCategoryExpression.v1"
dynamic "rule"{
      for_each = {for account in local.accounts_resources : account.name => account}
      content {
        value = rule.value.costcenter
        #Cannot be blank
        type = "REGULAR"
        rule {
            dimension {
              key           = "LINKED_ACCOUNT_NAME"
              values        = [rule.value.name]
              match_options = ["CONTAINS"]
            }
        }
      }
    }
}

