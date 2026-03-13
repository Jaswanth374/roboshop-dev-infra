resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.catalogue_sg_id]
  subnet_id = local.private_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap_catalogue" {
    triggers_replace = [
    aws_instance.catalogue.id
  ]
  connection {
    type        = "ssh"
    host        = aws_instance.catalogue.private_ip
    user        = "ec2-user"
    password = "DevOps321"
    timeout     = "5m"
    }
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  } 
  provisioner "remote-exec" {
    inline = [
    "sudo chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh catalogue"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  depends_on = [ terraform_data.bootstrap_catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}
