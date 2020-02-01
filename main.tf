# Configure the AWS provider
provider "aws" {
  region = "eu-west-1"
}


# create vpc
resource "aws_vpc" "app_vpc" {
  cidr_block =  "10.0.0.0/16"
  tags = {
    Name = var.name
  }
}




# Internet Gateway
resource "aws_internet_gateway" "app_gw" {
  vpc_id = aws_vpc.app_vpc.id



  tags = {
    Name = "${var.name} - IG"
  }
}


# Call module to create App tier
module "app" {
  source = "./modules/app_tier/"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gw.id
  name = var.name
  ami = var.ami
  db-instance-private-ip = module.db.db-instance-private-ip

}

# Call module to create DB tier
module "db" {
  source = "./modules/db_tier/"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_gw.id
  name = var.name
  ami = var.ami
  app_security_group_id = module.app.app_security_group_id
}
