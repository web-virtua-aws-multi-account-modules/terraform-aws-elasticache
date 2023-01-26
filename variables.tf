variable "name" {
  description = "ElastiCache name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet group name, It's necessaty at least one"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Subnet group name"
  type        = string
  default     = null
}

variable "log_group_name" {
  description = "Log group name"
  type        = string
  default     = null
}

variable "destination_type_log_group" {
  description = "Destination type to log group"
  type        = string
  default     = "cloudwatch-logs"
}

variable "log_format_log_group" {
  description = "Log format to log group"
  type        = string
  default     = "text"
}

variable "log_type_log_group" {
  description = "Log type log group"
  type        = string
  default     = "slow-log"
}

variable "security_group_ids" {
  description = "Security groups ids, It's necessaty at least one"
  type        = list(string)
  default     = null
}

variable "retention_in_days" {
  description = "Days to retention logs"
  type        = number
  default     = 7
}

variable "skip_destroy" {
  description = "If false when destroy the log group will be destroyed"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "Log group KMS key ID"
  type        = string
  default     = null
}

variable "engine" {
  description = "ElastiCache engine"
  type        = string
  default     = "redis"
}

variable "engine_version" {
  description = "ElastiCache engine version"
  type        = string
  default     = "6.2"
}

variable "node_type" {
  description = "ElastiCache node type"
  type        = string
  default     = "cache.t3.small"
}

variable "port" {
  description = "ElastiCache port"
  type        = number
  default     = 6379
}

variable "description" {
  description = "Description to elasticache"
  type        = string
  default     = "None"
}

variable "num_cache_clusters" {
  description = "Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups. This will attempt to automatically add or remove replicas, but provides no granular control (e.g., preferred availability zone, cache cluster ID) for the added or removed replicas. This also currently expects cache cluster IDs in the form of replication_group_id-00#"
  type        = number
  default     = 0
}

variable "parameter_group_name" {
  description = "Name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used"
  type        = string
  default     = null
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic_failover_enabled must also be enabled"
  type        = bool
  default     = false
}

variable "az_mode" {
  description = "Can be single-az or cross-az, is optional for Memcached only, whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1"
  type        = string
  default     = "single-az"
}

variable "availability_zone" {
  description = "Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred_availability_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource"
  type        = string
  default     = null
}

variable "preferred_availability_zones" {
  description = "It's only to Memcached, a list of the Availability Zones in which cache nodes are created"
  type        = list(string)
  default     = null
}

variable "apply_immediately" {
  description = "Whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type redis and if the engine version is 6 or higher. Defaults to true"
  type        = bool
  default     = true
}

variable "final_snapshot_name" {
  description = "Final snapshot name to ElastiCache when destroy resource"
  type        = string
  default     = null
}

variable "ip_discovery" {
  description = "The IP version to advertise in the discovery protocol, can be ipv4 or ipv6"
  type        = string
  default     = null
}

variable "network_type" {
  description = "The IP versions for cache cluster connections. IPv6 is supported with Redis engine 6.2 onword or Memcached version 1.6.6 for all Nitro system instances. Valid values are ipv4, ipv6 or dual_stack"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi, example: sun:05:00-sun:09:00"
  type        = string
  default     = null
}

variable "notification_topic_arn" {
  description = "ARN of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic"
  type        = string
  default     = null
}

variable "outpost_mode" {
  description = "Specify the outpost mode that will apply to the cache cluster creation. Valid values are single-outpost and cross-outpost, however AWS currently only supports single-outpost mode"
  type        = string
  default     = null
}

variable "preferred_outpost_arn" {
  description = "(Optional, Required if outpost_mode is specified) The outpost ARN in which the cache cluster will be created"
  type        = string
  default     = null
}

variable "replication_group_id" {
  description = "(Optional, Required if engine is not specified) ID of the replication group to which this cluster should belong. If this parameter is specified, the cluster is added to the specified replication group as a read replica; otherwise, the cluster is a standalone primary that is not part of any replication group"
  type        = string
  default     = null
}

variable "snapshot_arns" {
  description = "(Optional, Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. The object name cannot contain any commas. Changing snapshot_arns forces a new resource"
  type        = list(string)
  default     = null
}

variable "snapshot_name" {
  description = "(Optional, Redis only) Name of a snapshot from which to restore data into the new node group. Changing snapshot_name forces a new resource"
  type        = string
  default     = null
}

variable "snapshot_retention_limit" {
  description = "(Optional, Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = number
  default     = null
}

variable "snapshot_window" {
  description = "(Optional, Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: 05:00-09:00"
  type        = string
  default     = null
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, num_cache_clusters must be greater than 1"
  type        = bool
  default     = null
}

variable "num_replicas_per_node" {
  description = "Number of the replicas to each node"
  type        = number
  default     = null
}

variable "num_nodes_cluster" {
  description = "Number of nodes/shards on cluster"
  type        = number
  default     = null
}

variable "data_tiering_enabled" {
  description = "Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. This parameter must be set to true when using r6gd nodes"
  type        = bool
  default     = null
}

variable "transit_encryption_enabled" {
  description = "Whether to enable encryption in transit. user_group_ids - (Optional) User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid"
  type        = bool
  default     = null
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest. auth_token - (Optional) Password used to access a password protected server. Can be specified only if transit_encryption_enabled = true"
  type        = bool
  default     = null
}

variable "auth_token" {
  description = "Password used to access a password protected server. Can be specified only if transit_encryption_enabled = true"
  type        = string
  default     = null
}

variable "global_replication_group_id" {
  description = "The ID of the global replication group to which this replication group should belong. If this parameter is specified, the replication group is added to the specified global replication group as a secondary replication group; otherwise, the replication group is not part of any global replication group"
  type        = string
  default     = null
}

variable "user_group_ids" {
  description = "List of cache security group names to associate with this replication group"
  type        = list(string)
  default     = null
}

variable "security_group_names" {
  description = "List of cache security group names to associate with this replication group"
  type        = list(string)
  default     = null
}

variable "use_tags_default" {
  description = "If true will be use the tags default to ElastiCache"
  type        = bool
  default     = true
}

variable "tags_subnet_group" {
  description = "Tags to subnet group"
  type        = map(any)
  default     = {}
}

variable "tags_logs_group" {
  description = "Tags to log group"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "Tags to resources"
  type        = map(any)
  default     = {}
}

variable "ou_name" {
  description = "Organization unit name"
  type        = string
  default     = "no"
}
