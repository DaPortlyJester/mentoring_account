output "aws_region" {
  description = "AWS Region"
  value       = var.aws_region
}

output "cluster" {
  description = "Cluster name used for tag"
  value       = var.cluster
}

output "confidentiality" {
  description = "Confidentiality name used for tag"
  value       = var.confidentiality
}

output "name" {
  description = "Functional name for this implementation"
  value       = var.name
}

output "name_camelcase" {
  description = "Functional name as camel case"
  value       = var.name_camelcase
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "project_identifier" {
  description = "Project identifier (Netsuite number / identifier)"
  value       = var.project_identifier
}

output "repository" {
  value = var.repository
}

output "software_management" {
  description = "SoftwareManagement name used for tag"
  value       = var.software_management
}


output "tags" {
  description = "Tags to apply"
  value = {
    Cluster : var.cluster,
    Confidentiality : var.confidentiality,
    # DeployedBy : var.aws_role,
    Name : var.name,
    Project : var.project_name,
    Repository : var.repository,
    SoftwareManagement : var.software_management
  }
}
