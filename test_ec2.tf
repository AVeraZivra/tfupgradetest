provider "aws" {
  region = "us-east-2"
}
data "aws_ami" "awslinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20211103.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_key_pair" "new_key" {
  key_name   = "bastion"
  public_key = file("../id_rsa.pub")
  tags       = var.tags
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.awslinux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.new_key.key_name
  subnet_id     = aws_subnet.public1.id

  security_groups = [
    aws_security_group.allow_tls.id,
  ]

  tags = var.tags
}

# instance with private subnet
resource "aws_key_pair" "new_key_private" {
  key_name   = "private_instance_db"
  public_key = file("../id_rsa.pub")
  tags       = var.tags
}

resource "aws_instance" "DB" {
  ami           = data.aws_ami.awslinux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.new_key_private.key_name
  subnet_id     = aws_subnet.private1.id

  security_groups = [
    aws_security_group.my_sql_sg.id,
  ]

  tags = var.tags
}

# security groups
# webserver sg
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# DB sg
resource "aws_security_group" "my_sql_sg" {
  name        = "my_sql_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

