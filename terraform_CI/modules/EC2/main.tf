resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  user_data              = var.user_data
  tags = {
    Name = "ec2-with-eip"
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id

  tags = {
    Name = "ec2-eip"
  }
}

