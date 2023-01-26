# AWS ElastiCache for multiples accounts and regions with Terraform module
* This module simplifies creating and configuring of a ElastiCache across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enable of ElastiCache configurations for this module:

- Elasticache cluster
- Elasticache replication group
- Elasticache subnet group
- Cloudwatch log group

## Usage exemples to Redis

### Redis single zone

```hcl
module "tf_single_redis" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name               = "tf-single-redis"
  num_cache_clusters = 1
  availability_zone  = "us-east-1a"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Redis with 3 shards and 3 nodes

```hcl
module "tf_cluster_redis_1" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name                       = "tf-cluster-redis-1"
  num_nodes_cluster          = 3
  num_replicas_per_node      = 0
  automatic_failover_enabled = true
  description                = "Three nodes cluster and three shards"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
    "subnet-0evgf...fgrr"
  ]

  providers = {
    aws = aws.alias_profile_a
  }
}
```

### Redis with 3 shards and 9 nodes

```hcl
module "tf_cluster_redis_2" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name                       = "tf-cluster-redis-2"
  num_nodes_cluster          = 3
  num_replicas_per_node      = 2
  automatic_failover_enabled = true
  description                = "Nine nodes cluster and three shards"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
    "subnet-0evgf...fgrr"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### Redis with 1 shards, 3 nodes and 2 replicas

```hcl
module "tf_cluster_redis_3" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name                       = "tf-cluster-redis-3"
  num_cache_clusters         = 3

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
    "subnet-0evgf...fgrr"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

## Usage exemples to MemCached

### MemCached single zone

```hcl
module "tf_single_memcached" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name               = "tf-single-memcached"
  num_cache_clusters = 1
  engine             = "memcached"
  engine_version     = "1.6.17"
  port               = 11211
  availability_zone  = "us-east-1a"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
    "subnet-0evgf...fgrr"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### MemCached cluster with 3 nodes

```hcl
module "tf_cluster_memcached" {
  source = "web-virtua-aws-multi-account-modules/elasticache/aws"

  name               = "tf-cluster-memcached"
  num_cache_clusters = 3
  engine             = "memcached"
  engine_version     = "1.6.17"
  port               = 11211

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `-` | yes | ElastiCache name | `-` |
| subnet_ids | `list(string)` | `-` | yes | Subnet group name, It's necessaty at least one | `-` |
| subnet_group_name | `string` | `null` | no | Subnet group name | `-` |
| log_group_name | `string` | `null` | no | Log group name | `-` |
| destination_type_log_group | `string` | `cloudwatch-logs` | no | Destination type to log group | `-` |
| log_format_log_group | `string` | `text` | no | Log format to log group | `-` |
| log_type_log_group | `string` | `slow-log` | no | Log type log group | `-` |
| security_group_ids | `list(string)` | `null` | no | Security groups ids, It's necessaty at least one | `-` |
| retention_in_days | `number` | `7` | no | Days to retention logs | `-` |
| skip_destroy | `bool` | `false` | no | If false when destroy the log group will be destroyed | `*`false <br> `*`true |
| kms_key_id | `string` | `null` | no | Log group KMS key ID | `-` |
| engine | `string` | `redis` | no | ElastiCache engine | `-` |
| engine_version | `string` | `6.2` | no | ElastiCache engine version | `-` |
| node_type | `string` | `cache.t3.small` | no | ElastiCache node type | `-` |
| port | `number` | `6379` | no | ElastiCache port | `-` |
| description | `string` | `None` | no | Description to elasticache | `-` |
| num_cache_clusters | `number` | `0` | no | Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups. This will attempt to automatically add or remove replicas, but provides no granular control (e.g., preferred availability zone, cache cluster ID) for the added or removed replicas. This also currently expects cache cluster IDs in the form of replication_group_id-00# | `-` |
| parameter_group_name | `string` | `null` | no | Name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used | `-` |
| multi_az_enabled | `bool` | `false` | no | Specifies whether to enable Multi-AZ Support for the replication group. If true, automatic_failover_enabled must also be enabled | `*`false <br> `*`true |
| az_mode | `string` | `single-az` | no | Can be single-az or cross-az, is optional for Memcached only, whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1 | `*`single-az <br> `*`cross-az |
| availability_zone | `string` | `null` | no | Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred_availability_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource | `-` |
| preferred_availability_zones | `list(string)` | `null` | no | It's only to Memcached, a list of the Availability Zones in which cache nodes are created | `-` |
| apply_immediately | `bool` | `true` | no | Whether any database modifications are applied immediately, or during the next maintenance window | `*`false <br> `*`true |
| auto_minor_version_upgrade | `bool` | `true` | no | Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type redis and if the engine version is 6 or higher. Defaults to true | `*`false <br> `*`true |
| final_snapshot_name | `string` | `null` | no | Final snapshot name to ElastiCache when destroy resource | `-` |
| ip_discovery | `string` | `null` | no | The IP version to advertise in the discovery protocol, can be ipv4 or ipv6 | `-` |
| network_type | `string` | `null` | no | The IP versions for cache cluster connections. IPv6 is supported with Redis engine 6.2 onword or Memcached version 1.6.6 for all Nitro system instances. Valid values are ipv4, ipv6 or dual_stack | `-` |
| maintenance_window | `string` | `null` | no | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi, example: sun:05:00-sun:09:00 | `-` |
| notification_topic_arn | `string` | `null` | no | ARN of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic | `-` |
| outpost_mode | `string` | `null` | no | Specify the outpost mode that will apply to the cache cluster creation. Valid values are single-outpost and cross-outpost, however AWS currently only supports single-outpost mode | `-` |
| preferred_outpost_arn | `string` | `null` | no | (Optional, Required if outpost_mode is specified) The outpost ARN in which the cache cluster will be created | `-` |
| replication_group_id | `string` | `null` | no | (Optional, Required if engine is not specified) ID of the replication group to which this cluster should belong. If this parameter is specified, the cluster is added to the specified replication group as a read replica; otherwise, the cluster is a standalone primary that is not part of any replication group | `-` |
| snapshot_arns | `list(string)` | `null` | no | (Optional, Redis only) Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. The object name cannot contain any commas. Changing snapshot_arns forces a new resource | `-` |
| snapshot_name | `string` | `null` | no | (Optional, Redis only) Name of a snapshot from which to restore data into the new node group. Changing snapshot_name forces a new resource | `-` |
| snapshot_retention_limit | `number` | `null` | no | (Optional, Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them | `-` |
| snapshot_window | `string` | `null` | no | (Optional, Redis only) Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: 05:00-09:00 | `-` |
| automatic_failover_enabled | `bool` | `null` | no | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, num_cache_clusters must be greater than 1 | `*`false <br> `*`true |
| num_replicas_per_node | `number` | `null` | no | Number of the replicas to each node | `-` |
| num_nodes_cluster | `number` | `null` | no | Number of nodes/shards on cluster | `-` |
| data_tiering_enabled | `bool` | `null` | no | Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. This parameter must be set to true when using r6gd nodes | `*`false <br> `*`true |
| transit_encryption_enabled | `bool` | `null` | no | Whether to enable encryption in transit. user_group_ids - (Optional) User Group ID to associate with the replication group. Only a maximum of one (1) user group ID is valid | `*`false <br> `*`true |
| at_rest_encryption_enabled | `bool` | `false` | no | Whether to enable encryption at rest. auth_token - (Optional) Password used to access a password protected server. Can be specified only if transit_encryption_enabled = true | `*`false <br> `*`true |
| auth_token | `string` | `null` | no | Password used to access a password protected server. Can be specified only if transit_encryption_enabled = true | `-` |
| global_replication_group_id | `string` | `null` | no | The ID of the global replication group to which this replication group should belong. If this parameter is specified, the replication group is added to the specified global replication group as a secondary replication group; otherwise, the replication group is not part of any global replication group | `-` |
| user_group_ids | `list(string)` | `null` | no | List of cache security group names to associate with this replication group | `-` |
| security_group_names | `list(string)` | `null` | no | List of cache security group names to associate with this replication group | `-` |
| use_tags_default | `bool` | `true` | no | If true will be use the tags default to ElastiCache | `*`false <br> `*`true |
| tags_subnet_group | `map(any)` | `{}` | no | Tags to subnet group | `-` |
| tags_logs_group | `map(any)` | `{}` | no | Tags to log group | `-` |
| tags | `map(any)` | `{}` | no | Tags to resources | `-` |
| ou_name | `string` | `no` | no | Organization unit name | `-` |


## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.create_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_replication_group.create_replication_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.create_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_cloudwatch_log_group.create_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `elasticache` | All Elasticache |
| `elasticache_arn` | Elasticache ARN |
| `elasticache_cluster_address` | Elasticache cluster address |
| `elasticache_configuration_endpoint` | Elasticache configuration endpoint |
| `elasticache_engine_version_actual` | Elasticache engine version actual |
| `elasticache_port` | Elasticache port |
| `elasticache_ip_discovery` | Elasticache IP discovery |
| `elasticache_maintenance_window` | Elasticache maintenance window |
| `elasticache_parameter_group_name` | Elasticache parameter group name |
| `elasticache_snapshot_window` | Elasticache snapshot window |
| `elasticache_primary_endpoint_address` | Elasticache primary endpoint address |
| `elasticache_reader_endpoint_address` | Elasticache reader endpoint address |
