variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "cluster" {
  description = "Cluster name used for tagging purposes"
  default     = "governance"
}

variable "confidentiality" {
  description = "Confidentiality name used for tagging purposes"
  default     = "internal"
}

variable "name" {
  description = "Functional name for shared AWS logging"
  default     = "governance"
}

variable "name_camelcase" {
  description = "Camel Case name for consistency"
  default     = "Governance"
}

variable "project_identifier" {
  description = "Project identifier that correlates to the Netsuite project / team executing this deploy"
  default     = "primary"
}

variable "project_name" {
  description = "Project name from netsuite used for tagging purposes"
  default     = "Terraform mentoring account management"
}

variable "repository" {
  description = "Github Repository"
  default     = "https://github.com/DaPortlyJester/mentoring_account.git"
}

variable "software_management" {
  description = "Software Management name used for tagging purposes"
  default     = "terraform"
}
