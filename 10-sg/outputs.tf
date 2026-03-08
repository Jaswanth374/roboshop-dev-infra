/* /* output "az_info" {
  value = module.vpc.zone_info
} */

/* output "vpc_id" {

  value = data.aws_ssm_parameter.vpc_id.value
}

output "sg_id" {

  value = module.sg
} */ 

output "sg_id" {
  value = module.sg[*].sg_id
}