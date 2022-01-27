#################################################
## OIDC Provider
#################################################

# The OIDC provider provides github actions from the repository
# to generate a tokens
resource "aws_iam_openid_connect_provider" "github_oidc" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "https://github.com/DaPortlyJester"
  ]

  thumbprint_list = ["6938FD4D98BAB03FAADB97B34396831E3780AEA1"]

  tags   = merge(local.tags, {
    Name = "daportlyjester-github-actions-oidc-provider"
  })

}

#################################################
## IAM Role, Policies, and Attachments
#################################################

data "aws_iam_policy_document" "github_oidc" {
  statement {
    sid     = "AllowGithubAssumeRole"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_oidc.arn
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:DaPortlyJester/mentoring_account:*",
        # Support PRs
        # "repo:DaPortlyJester/*",
        # Support main branch builds
        # "repo:DaPortlyJester/*:ref:refs/heads/main"
      ]
    }
  }
}

resource "aws_iam_role" "github_oidc" {
  name = "github_actions_oidc_role"
  path = "/oidc/"

  assume_role_policy = data.aws_iam_policy_document.github_oidc.json

  tags = merge(local.tags, {
    Name = "github-actions-oidc-role"
  })

}

resource "aws_iam_role_policy_attachment" "github_oidc_ro" {
  role       = aws_iam_role.github_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Enable for admin access
resource "aws_iam_role_policy_attachment" "github_oidc_admin" {
  role       = aws_iam_role.github_oidc.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Enable for power access (non IAM)
# resource "aws_iam_role_policy_attachment" "github_oidc_power" {
#   role       = aws_iam_role.github_oidc.name
#   policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
# }