module "sg" {
    source = "../../terraform-aws-sg"
    project = var.project
    environment = var.environment
    count = length (var.sg_names)
    sg_name = replace(var.sg_names[count.index], "_", "-")
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}