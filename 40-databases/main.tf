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

resource "terraform_data" "bootstrap_mongodb" {
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
    destination = "/tmp/bootstrap.sh"
  } 
provisioner "remote-exec" {
    inline = [
    "sudo chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh mongodb ${var.environment}"
    ]
  }
}


resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.redis_sg_id]
  subnet_id = local.database_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-redis"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap_redis" {
    triggers_replace = [
    aws_instance.redis.id
  ]
connection {
    type        = "ssh"
    host        = aws_instance.redis.private_ip
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
    "sudo sh /tmp/bootstrap.sh redis ${var.environment}"
    ]
  }
}


resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.mysql_sg_id]
  subnet_id = local.database_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mysql"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap_mysql" {
    triggers_replace = [
    aws_instance.mysql.id
  ]
connection {
    type        = "ssh"
    host        = aws_instance.mysql.private_ip
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
    "sudo sh /tmp/bootstrap.sh mysql ${var.environment}"
    ]
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    },
    local.common_tags
  )
} 

resource "terraform_data" "bootstrap_rabbitmq" {
    triggers_replace = [
    aws_instance.mysql.id
  ]
connection {
    type        = "ssh"
    host        = aws_instance.rabbitmq.private_ip
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
    "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment}"
    ]
  }
}