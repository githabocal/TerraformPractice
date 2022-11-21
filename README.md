# Terraform

- Create a user in IAM for Terraform
    - Add user with Access Key for Select AWS credential type because we need to enable an access key ID and secret access key for the AWS API, CLI, SDK and other development tools.
    - Next is Permission: Make sure Terraform has enough permission to be able to create and delete resources as needed
      - Attach existing policies directly:
        - AdministratorAccess
    - Make sure to download CSV file for the credentials
    - Then in the terminal, to use your IAM credentials to authenticate the Terraform AWS provider, set the AWS_ACCESS_KEY_ID environment variable.
      - export AWS_ACCESS_KEY_ID=
      - export AWS_SECRET_ACCESS_KEY=
    - aws iam get-user --user-name <"username for IAM">
  - Create a main.tf file
    - ```
        terraform {
        required_providers {
            aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
            }
        }

        required_version = ">= 1.2.0"
        }

        provider "aws" {
        region  = "us-west-2"
        }
        ```
  - Create a s3.tf file
    - ```
        resource "aws_s3_bucket" "b" {
            bucket = "terraform-bucket"

        }
        ```
  - Create a s3 bucket deletion policy
    - ```
        resource "aws_s3_bucket_policy" "prevent_deletion" {
          bucket = aws_s3_bucket.s3.id
          policy = data.aws_iam_policy_document.prevent_deletion_policy.json
        }

        data "aws_iam_policy_document" "prevent_deletion_policy" {
          statement {
            effect = "Deny"
            principals {
              type        = "AWS"
              identifiers = ["123456789012"]
            }
            actions = [
              # "s3:GetObject",
              # "s3:ListBucket",
              "s3:DeleteBucket"
            ]

            resources = [
              # aws_s3_bucket.arn,
              # "${aws_s3_bucket.arn}/*"
            ]
          }
        }
        ```
  - Then apply then terraform commands as follows;
      - terraform init
      - terraform fmt
      - terraform validate
      - terraform plan
      - terraform apply
### Sources for main.tf and s3.tf:
- [learn.hashicorp.com](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket