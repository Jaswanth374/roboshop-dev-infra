locals {
    public_subnet_id = split (",", data.aws_ssm_parameter.public_subnet_id.value)[0]
    private_subnet_id = split (",", data.aws_ssm_parameter.private_subnet_id.value)[0]
    ami_id = data.aws_ami.ami.id
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}