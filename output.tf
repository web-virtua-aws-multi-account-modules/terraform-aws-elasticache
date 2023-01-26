output "elasticache" {
  description = "Elasticache"
  value       = try(aws_elasticache_cluster.create_cluster[0], aws_elasticache_replication_group.create_replication_group[0])
  sensitive = true
}

output "elasticache_arn" {
  description = "Elasticache ARN"
  value       = try(aws_elasticache_cluster.create_cluster[0].arn, aws_elasticache_replication_group.create_replication_group[0].arn)
}

output "elasticache_cluster_address" {
  description = "Elasticache cluster address"
  value       = try(aws_elasticache_cluster.create_cluster[0].cluster_address, aws_elasticache_replication_group.create_replication_group[0].primary_endpoint_address)
}

output "elasticache_configuration_endpoint" {
  description = "Elasticache configuration endpoint"
  value       = try(aws_elasticache_cluster.create_cluster[0].configuration_endpoint, aws_elasticache_replication_group.create_replication_group[0].configuration_endpoint_address)
}

output "elasticache_engine_version_actual" {
  description = "Elasticache engine version actual"
  value       = try(aws_elasticache_cluster.create_cluster[0].engine_version_actual, aws_elasticache_replication_group.create_replication_group[0].engine_version_actual)
}

output "elasticache_port" {
  description = "Elasticache port"
  value       = try(aws_elasticache_cluster.create_cluster[0].port, aws_elasticache_replication_group.create_replication_group[0].port)
}

output "elasticache_ip_discovery" {
  description = "Elasticache IP discovery"
  value       = try(aws_elasticache_cluster.create_cluster[0].ip_discovery, null)
}

output "elasticache_maintenance_window" {
  description = "Elasticache maintenance window"
  value       = try(aws_elasticache_cluster.create_cluster[0].maintenance_window, aws_elasticache_replication_group.create_replication_group[0].maintenance_window)
}

output "elasticache_parameter_group_name" {
  description = "Elasticache parameter group name"
  value       = try(aws_elasticache_cluster.create_cluster[0].parameter_group_name, aws_elasticache_replication_group.create_replication_group[0].parameter_group_name)
}

output "elasticache_snapshot_window" {
  description = "Elasticache snapshot window"
  value       = try(aws_elasticache_cluster.create_cluster[0].snapshot_window, aws_elasticache_replication_group.create_replication_group[0].snapshot_window)
}

output "elasticache_primary_endpoint_address" {
  description = "Elasticache primary endpoint address"
  value       = try(aws_elasticache_replication_group.create_replication_group[0].primary_endpoint_address, null)
}

output "elasticache_reader_endpoint_address" {
  description = "Elasticache reader endpoint address"
  value       = try(aws_elasticache_replication_group.create_replication_group[0].reader_endpoint_address, null)
}
