# What is this repository?
This repoistory (for now) holds the AWS account request automation components.

## Who owns this repository?
The BioNTech CCoE team led by Nils Kreft

## Requirements
 - Terraform 1.3
    - AWS Provider 4.32 (stable)
    - AzureAD Provider 2.28 (stable)
 - Azure AD service principal and credentials in the environment



 
## How do I run this?
Clone the repository locally and execute:
```terraform init ```
setup the enivornment and populate with AWS role and Azure AD credentials for the service principal 
### Azure AD
``` 
export ARM_CLIENT_ID=""
export ARM_TENANT_ID=""
export ARM_CLIENT_SECRET=""
```

### AWS
```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_SESSION_TOKEN=""
```
Do some 
```terraform plan ```
and run eventually with - run 
```terraform apply```
Due to the use of templates that are in turn TF code you need to run ```terraform apply``` twice for terraform to pick up the rendered terraform code. 


## What is the layout of the repository?
This repoistory aims at following good practices for Terraform repository layouts and the following conventions are in use:

```scripts/```
 - Contains non-native resources called by either remote or local execution providers
