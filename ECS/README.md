<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/alb | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./modules/ecs | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appointment_repo_uri"></a> [appointment\_repo\_uri](#input\_appointment\_repo\_uri) | The appointment image repo URL | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The Environment we are using | `string` | n/a | yes |
| <a name="input_patient_repo_uri"></a> [patient\_repo\_uri](#input\_patient\_repo\_uri) | The Patient image repo URL | `string` | n/a | yes |
| <a name="input_priv_sub_count"></a> [priv\_sub\_count](#input\_priv\_sub\_count) | Number of private subnets | `number` | n/a | yes |
| <a name="input_pub_sub_count"></a> [pub\_sub\_count](#input\_pub\_sub\_count) | Number of public subnets | `number` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_end_point_anme"></a> [alb\_end\_point\_anme](#output\_alb\_end\_point\_anme) | The DNS name of the Load Balancer |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | n/a |
| <a name="output_my_vpc_id"></a> [my\_vpc\_id](#output\_my\_vpc\_id) | n/a |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
<!-- END_TF_DOCS -->