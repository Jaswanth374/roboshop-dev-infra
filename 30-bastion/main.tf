resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  user_data = file("bastion.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-bastion"
    },
    local.common_tags
  )
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    # EBS volume tags
    tags = merge(
      {
          Name = "${var.project}-${var.environment}-bastion"
      },
    local.common_tags
    )
  }
}


/* resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids= [local.mongodb_sg_id]
  subnet_id = local.private_subnet_id
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags
  )
} */

resource "aws_iam_role" "bastion" {
  name = "BastionRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-BastionRole"
    },
    local.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}-BastionRole"
  role = aws_iam_role.bastion.name
}