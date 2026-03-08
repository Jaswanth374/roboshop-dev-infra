resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap" {
    triggers_replace = [
    aws_instance.mongodb.id
  ]
connection {
    type        = "ssh"
    host        = aws_instance.mongodb.private_ip
    user        = "ec2-user"
    password = "DevOps321"
    timeout     = "5m"
    }
 provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bpptstrap.sh"
  } 
provisioner "remote -exec" {
    inline = [
    "cd /tmp/bootstrap.sh",
    "sudo chmod +x bootstrap.sh"
    ]
  }
}
