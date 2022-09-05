<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rds"></a> [rds](#module\_rds) | terraform-aws-modules/rds/aws | 5.0.3 |

## Resources

| Name | Type |
|------|------|
| [aws_security_groups.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnets.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The number of days to keep backups for | `number` | `1` | no |
| <a name="input_database_backup_window"></a> [database\_backup\_window](#input\_database\_backup\_window) | The time window you want to perform maintenance in | `string` | `"03:00-06:00"` | no |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | The database engine you want to use, i.e MySQL, Postgres, etc | `string` | `"mysql"` | no |
| <a name="input_database_engine_version"></a> [database\_engine\_version](#input\_database\_engine\_version) | The version of the database engine you want to use | `string` | `"5.7.25"` | no |
| <a name="input_database_family"></a> [database\_family](#input\_database\_family) | The family of the database engine you want to use | `string` | `"mysql5.7"` | no |
| <a name="input_database_major_engine_version"></a> [database\_major\_engine\_version](#input\_database\_major\_engine\_version) | The major version of the database engine you want to use | `string` | `"5.7"` | no |
| <a name="input_database_options"></a> [database\_options](#input\_database\_options) | The time window you want to perform maintenance in | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| <a name="input_database_parameters"></a> [database\_parameters](#input\_database\_parameters) | The options you want to use for the database | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "character_set_client",<br>    "value": "utf8mb4"<br>  },<br>  {<br>    "name": "character_set_server",<br>    "value": "utf8mb4"<br>  }<br>]</pre> | no |
| <a name="input_database_password"></a> [database\_password](#input\_database\_password) | The database password to use for this database | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment you are provisioning in | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | The instance defines the instance class which should be used by the database | `string` | `"db.t3.medium"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the database you want to create | `string` | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | The size in megabytes of the storage device you want to use | `number` | `10` | no |

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
