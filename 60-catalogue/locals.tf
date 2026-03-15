locals {

    common_tags = {
    
            project = var.project
            environment = var.environment
            terraform = "true"
        
    }
    ami_id = data.aws_ami.ami.id
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
    catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}