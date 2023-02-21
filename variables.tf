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
  default     = "8774f594-1d59-4279-xxxx-59ef09a23530"

}
variable "aws_sso_azuread_resource_object_id" {
  type        = string
  description = "This is the object ID of the enterprise app."
  default     = "4611faa5-b5fe-4a79-aexx-f71343c6b9bc"
}

variable "permission_sets" {
  type        = list(any)
  description = "The list of names of exiting permission sets in AWS Identity Center."
  default     = ["PowerUserAccess", "AdministratorAccess", "ViewOnlyAccess"]
}

variable "account_email_prefix" {
  type        = string
  description = "The string to place in front of the email address for aws accounts (including + addressing"
  default     = "skevalku+"
}

variable "account_email_maildomain" {
  type        = string
  description = "The email domain used for aws accounts"
  default     = "amazon.com"
}

variable "azure_ad_group_prefix" {
  type        = string
  description = "The string to place before the account name (excluding including separator ``_'')"
  default     = "AWS_RBAC_kfl"
}

variable "account_sso_email" {
  type    = string
  default = "skevalku@amazon.com"
}

variable "account_sso_name" {
  type        = string
  description = "The SSO First AND Last name used when privisioning CT account factory product."
  default     = "Automation"
}

variable "managed_resource_prefix" {
  type        = string
  description = "String value for resouces in AWS created with this automation."
  default     = "terraform-kf-cpt-skevalku"
}


variable "ou_mapping_table" {
  type = map(any)
  default = {
    "Automations"        = "Automations",
    "Sandbox"            = "Sandbox",
    "Graveyard"          = "Graveyard",
    "Exceptions"         = "Exceptions"
  }
}

