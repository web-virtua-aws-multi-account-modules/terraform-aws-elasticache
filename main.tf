locals {
  tags_default = {
    "Name"      = var.name
    "tf-aws-mq" = var.name
    "tf-ou"     = var.ou_name
  }

  subnet_group_tags = {
    "Name"            = var.name
    "tf-subnet-group" = var.name
    "tf-ou"           = var.ou_name
  }

  log_group_tags = {
    "Name"         = var.name
    "tf-log-group" = var.name
    "tf-ou"        = var.ou_name
  }
}

resource "aws_elasticache_subnet_group" "create_subnet_group" {
  count = var.subnet_group_name == null ? 1 : 0

  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags_subnet_group, var.use_tags_default ? local.subnet_group_tags : {})
}

resource "aws_cloudwatch_log_group" "create_log_group" {
  count = var.log_group_name == null ? 1 : 0

  name              = "${var.name}-log-group"
  retention_in_days = var.retention_in_days
  skip_destroy      = var.skip_destroy
  kms_key_id        = var.kms_key_id
  tags              = merge(var.tags_logs_group, var.use_tags_default ? local.log_group_tags : {})
}

resource "aws_elasticache_cluster" "create_cluster" {
  count = (var.num_cache_clusters == 1 || var.engine == "memcached") ? 1 : 0

  cluster_id                   = var.name
  engine                       = var.engine
  engine_version               = var.engine_version
  node_type                    = var.node_type
  port                         = var.port
  num_cache_nodes              = var.num_cache_clusters
  parameter_group_name         = var.parameter_group_name
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  security_group_ids           = var.security_group_ids
  subnet_group_name            = try(aws_elasticache_subnet_group.create_subnet_group[0].name, var.subnet_group_name)
  az_mode                      = var.az_mode
  availability_zone            = var.availability_zone
  preferred_availability_zones = var.preferred_availability_zones
  final_snapshot_identifier    = var.final_snapshot_name
  ip_discovery                 = var.ip_discovery
  maintenance_window           = var.maintenance_window
  network_type                 = var.network_type
  notification_topic_arn       = var.notification_topic_arn
  outpost_mode                 = var.outpost_mode
  preferred_outpost_arn        = var.preferred_outpost_arn
  replication_group_id         = var.replication_group_id
  snapshot_arns                = var.snapshot_arns
  snapshot_name                = var.snapshot_name
  snapshot_retention_limit     = var.snapshot_retention_limit
  snapshot_window              = var.snapshot_window
  tags                         = merge(var.tags, var.use_tags_default ? local.tags_default : {})

  dynamic "log_delivery_configuration" {
    for_each = var.engine == "redis" ? [1] : []

    content {
      destination      = try(aws_cloudwatch_log_group.create_log_group[0].name, var.log_group_name)
      destination_type = var.destination_type_log_group
      log_format       = var.log_format_log_group
      log_type         = var.log_type_log_group
    }
  }
}

resource "aws_elasticache_replication_group" "create_replication_group" {
  count = ((var.num_cache_clusters == 0 || var.num_cache_clusters > 1) && var.engine == "redis") ? 1 : 0

  replication_group_id        = var.name
  description                 = var.description
  engine                      = var.engine
  engine_version              = var.engine_version
  node_type                   = var.node_type
  port                        = var.port
  num_cache_clusters          = var.num_cache_clusters > 0 ? var.num_cache_clusters : null
  parameter_group_name        = var.parameter_group_name
  apply_immediately           = var.apply_immediately
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  security_group_ids          = var.security_group_ids
  subnet_group_name           = try(aws_elasticache_subnet_group.create_subnet_group[0].name, var.subnet_group_name)
  preferred_cache_cluster_azs = var.preferred_availability_zones
  multi_az_enabled            = var.multi_az_enabled
  final_snapshot_identifier   = var.final_snapshot_name
  maintenance_window          = var.maintenance_window
  notification_topic_arn      = var.notification_topic_arn
  snapshot_arns               = var.snapshot_arns
  snapshot_name               = var.snapshot_name
  snapshot_retention_limit    = var.retention_in_days
  snapshot_window             = var.snapshot_window
  automatic_failover_enabled  = var.automatic_failover_enabled
  tags                        = merge(var.tags, var.use_tags_default ? local.tags_default : {})
  num_node_groups             = var.num_nodes_cluster != null ? var.num_nodes_cluster : null
  replicas_per_node_group     = var.num_replicas_per_node
  data_tiering_enabled        = var.data_tiering_enabled
  transit_encryption_enabled  = var.transit_encryption_enabled
  at_rest_encryption_enabled  = var.at_rest_encryption_enabled
  auth_token                  = var.auth_token
  global_replication_group_id = var.global_replication_group_id
  kms_key_id                  = var.kms_key_id
  user_group_ids              = var.user_group_ids
  security_group_names        = var.security_group_names

  log_delivery_configuration {
    destination      = try(aws_cloudwatch_log_group.create_log_group[0].name, var.log_group_name)
    destination_type = var.destination_type_log_group
    log_format       = var.log_format_log_group
    log_type         = var.log_type_log_group
  }
}
