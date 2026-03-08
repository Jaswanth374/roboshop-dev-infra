locals {
    common_tags = {
        type = map
        default = {
            project = var.project
            environment = var.environment
            terraform = "true"
        }
    }
    ami_id = data.aws_ami.ami.id
    database_subnet_id = data.aws_ssm_parameter.database_subnet_id.value
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
}