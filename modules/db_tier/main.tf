# Main for DB tier
# Place all the resources that contain the PRIVATE app is here.

# Create a subnet
resource "aws_subnet" "db_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
   Name = "db"
  }
}

# Create Security Group
resource "aws_security_group" "db_sg" {
  name        = "db"
  description = "Allow traffic from app on port 27017 and the apps ip"
  vpc_id      = var.vpc_id


  ingress {
   from_port   = 27017
   to_port     = 27017
   protocol    = "tcp"
   security_groups = [var.app_security_group_id]
 }


  tags = {
    Name = "db"
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# Launch an instance
resource "aws_instance" "app_instance" {
  ami                         = "ami-02087d02a37492c20"
  subnet_id                   = aws_subnet.db_subnet.id
  vpc_security_group_ids      = [aws_security_group.db_sg.id]
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "instance of db"
  }
}
