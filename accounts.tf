resource "aws_servicecatalog_provisioned_product" "accounts" {
  for_each                 = { for account in local.accounts_resources : account.name => account }
  name                     = each.value.name
  product_id               = "prod-5az27pfgr7a4i"
  provisioning_artifact_id = "pa-4tozzdhl2byuk"
  path_id = "lpv2-6kx26wpwa6r7y"

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

resource "aws_s3_bucket" "terraform_state_s3" {
  bucket        = "${var.managed_resource_prefix}-state"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "s3_versioning_tf_state" {
  bucket = aws_s3_bucket.terraform_state_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "s3_sse_tf_state" {
  bucket = aws_s3_bucket.terraform_state_s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "${var.managed_resource_prefix}-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

