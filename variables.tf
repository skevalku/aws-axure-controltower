/* update this here once CT upgrades the account factory provisioning artefact id */
variable "aws_ct_acount_provisioning_artifact_id" {
  type    = string
  default = "pa-4tozzdhl2byuk"
}


variable "aws_ct_account_factory_product_id" {
  type    = string
  default = "prod-5az27pfgr7a4i"
}

variable "aws_sso_azuread_app" {
  type    = string
  default = "AWS Single Sign-on"
}

variable "aws_sso_azuread_app_roleid" {
  type        = string
  description = "This is the built in role id for ``user'' role."
  default     = "8774f594-1d59-4279-b9d9-59ef09a23530"

}
variable "aws_sso_azuread_resource_object_id" {
  type        = string
  description = "This is the object ID of the enterprise app."
  default     = "4611faa5-b5fe-4a79-aec2-f71343c6b9bc"
}

variable "permission_sets" {
  type        = list(any)
  description = "The list of names of exiting permission sets in AWS Identity Center."
  default     = ["PowerUserAccess", "AdministratorAccess", "ViewOnlyAccess"]
}

variable "account_email_prefix" {
  type        = string
  description = "The string to place in front of the email address for aws accounts (including + addressing"
  default     = "pfo+"
}

variable "account_email_maildomain" {
  type        = string
  description = "The email domain used for aws accounts"
  default     = "amazon.com"
}

variable "azure_ad_group_prefix" {
  type        = string
  description = "The string to place before the account name (excluding including separator ``_'')"
  default     = "AWS_RBAC_biontechglobal"
}

variable "account_sso_email" {
  type    = string
  default = "petar.forai@gmail.com"
}

variable "account_sso_name" {
  type        = string
  description = "The SSO First AND Last name used when privisioning CT account factory product."
  default     = "Automation"
}

variable "managed_resource_prefix" {
  type        = string
  description = "String value for resouces in AWS created with this automation."
  default     = "terraform-ccoe-platform"
}


variable "ou_mapping_table" {
  type = map(any)
  default = {
    "Automations"        = "Automations",
    "Sandbox"            = "Sandbox",
    "Graveyard"          = "Graveyard",
    "Exceptions"         = "Exceptions",
    "Non-Qualified-Prod" = "Non-Qualified-Prod (ou-zzl0-fxx3fso3)",
    "Non-Qualified-Dev"  = "Non-Qualified-Dev (ou-zzl0-aklizy9i)",
    "Non-Qualified-Int"  = "Non-Qualified-Int (ou-zzl0-8f2zkw7w)",
    "Non-Qualified-Val"  = "Non-Qualified-Val (ou-zzl0-1hs0fvzh)",
    "Non-Qualified-Trg"  = "Non-Qualified-Trg (ou-zzl0-1leuitgu)",
    "Qualified-Dev"      = "Qualified-Dev (ou-2jnw-oifew93l)",
    "Qualified-Val"      = "Qualified-Val (ou-zzl0-0gjcw7kr)",
    "Qualified-Trg"      = "Qualified-Trg (ou-zzl0-52tceh1m)",
    "Qualified-Int"      = "Qualified-Int (ou-zzl0-cvz993zz)",
    "Qualified-Prod"     = "Qualified-Prod (ou-zzl0-pvpvxasg)",
    "CrazyStuff"         = "CrazyStuff (ou-2jnw-88q6y65k)"
  }
}


resource "aws_s3_bucket" "terraform_state_s3" {
  bucket        = "terraform-skevalku-state-123"
  force_destroy = true
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tf_state_bpa" {
  bucket = aws_s3_bucket.terraform_state_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
