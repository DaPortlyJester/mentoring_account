# Terraform: Mentoring Account

## Overview

This repository manintains configuration / setup for the terraform for the mentoring account.

### Terraform Persistence

Maintains S3 Buckets and DynamoDB lock tables for terraform remote state in management account

### AWS OIDC Federation

Maintains AWS OIDC Federation for Github Actions in this account.

* Github OIDC provider
* Credentials MUST never be added to this repository.

## Reference Information

### Github Actions

<https://github.com/hashicorp/setup-terraform>
<https://tfsec.dev/docs/github-action/>

#### OIDC

<https://awsteele.com/blog/2021/09/15/aws-federation-comes-to-github-actions.html>
<https://blog.alexellis.io/deploy-without-credentials-using-oidc-and-github-actions/>
<https://github.com/google-github-actions/auth>
<https://github.com/google-github-actions/auth#examples>
<https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token>
<https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions#permissions>

### Terraform

<https://registry.terraform.io/providers/hashicorp/aws/latest/docs>
<https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization>

[Build]: https://github.com/DaPortlyJester/mentoring_account/actions/workflows/terraform_validate.yml
[Build status]: https://github.com/DaPortlyJester/mentoring_account/actions/workflows/terraform_validate.yml/badge.svg
[semantic-release Badge]: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
[semantic-release]: https://github.com/semantic-release/semantic-release
