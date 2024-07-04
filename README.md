<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.34 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.56.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws | 6.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_ingress_rule.rds_allow_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `number` | `20` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | The CIDR blocks you want to allow access to the RDS instance | `map(string)` | `{}` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The number of days to keep backups for | `number` | `1` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | The time window you want to perform backups in | `string` | `"01:00-03:00"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database you want to create | `string` | n/a | yes |
| <a name="input_engine"></a> [engine](#input\_engine) | The database engine you want to use i.e mysql, postgres, etc | `string` | `"mysql"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine you want to use | `string` | `"8.0"` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the database engine you want to use | `string` | `"mysql8.0"` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | `"db.t3.micro"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The time window you want to perform maintenance in | `string` | `"Mon:04:00-Mon:06:00"` | no |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | The major version of the database engine you want to use | `string` | `"8.0"` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | The options you want to use for the database | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "character_set_client",<br>    "value": "utf8mb4"<br>  },<br>  {<br>    "name": "character_set_server",<br>    "value": "utf8mb4"<br>  }<br>]</pre> | no |
| <a name="input_port"></a> [port](#input\_port) | The port the database should listen on | `number` | `3306` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The Subnet IDs you want to use for the RDS instance | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags you want to apply to the RDS instance | `map(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | The username you want to use for the database | `string` | `"root"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID that the RDS instance will be within | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_endpoint"></a> [database\_endpoint](#output\_database\_endpoint) | The hostname to use to connect to the database |
| <a name="output_database_host"></a> [database\_host](#output\_database\_host) | The hostname to use to connect to the database |
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | The name of the database created |
| <a name="output_database_password"></a> [database\_password](#output\_database\_password) | The password to use to connect to the database |
| <a name="output_database_port"></a> [database\_port](#output\_database\_port) | The port to use to connect to the database |
| <a name="output_database_user"></a> [database\_user](#output\_database\_user) | The username to use to connect to the database |
<!-- END_TF_DOCS -->
