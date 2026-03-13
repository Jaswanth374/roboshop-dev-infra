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
