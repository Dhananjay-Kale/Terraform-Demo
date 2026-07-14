# Define Remote Backend
terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}
#define provider
provider "aws" {
    region = "ap-south-1"
}

#define VPC
resource "aws_vpc" "tf-vpc" {
    cidr_block = var.vpc-cidr
    tags = {
        Name = "${var.project_name}-vpc"
    }

}
#define private subnet
resource "aws_subnet" "tf-private-subnet" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = var.private_cidr
    availability_zone = var.az1
    tags = {
        Name = "${var.project_name}_pvt_Subnet"
    }
  
}

resource "aws_subnet" "tf-public-subnet" {
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = var.public_cidr
    availability_zone = var.az2
    map_public_ip_on_launch = true    #auto assign ip is unable
    tags = {
        Name = "${var.project_name}_pub_subnet"
    }
  
}
#define internet gateway
resource "aws_internet_gateway" "tf-IGW" {
  vpc_id = aws_vpc.tf-vpc.id
   tags = {
        Name = "${var.project_name}-IGW"
    }
}

#use existing route table which is created by VPC
resource "aws_default_route_table" "tf-main-RT" {
    default_route_table_id = aws_vpc.tf-vpc.default_route_table_id
    tags = {
        Name = "${var.project_name}-main-RT"
    }
  
}
#define routes in main route table
resource "aws_route" "tf-route" {
    route_table_id = aws_vpc.tf-vpc.default_route_table_id
    destination_cidr_block = var.IGW-cidr
    gateway_id = aws_internet_gateway.tf-IGW.id
}
# define security group
resource "aws_security_group" "tf-SG" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
        Name = "${var.project_name}-SG"
    }
#incomming rules
        ingress {
        description = "allow ssh"
        to_port = 22
        from_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "alow http"
        to_port = 80
        from_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "alow mysql"
        to_port = 3306
        from_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
#define outgoing
    egress {
        description = "alllow all traffic"
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    depends_on = [ aws_vpc.tf-vpc ]
}

#define app server in private subnet
resource "aws_instance" "tf-app-server" {
    subnet_id = aws_subnet.tf-private-subnet.id
    availability_zone = var.az1
    ami = var.ami
    key_name = var.key
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.tf-SG.id]
      tags = {
        Name = "${var.project_name}-app-server"
    }
    depends_on = [ aws_security_group.tf-SG ]
}
#define webserver in public subnet
resource "aws_instance" "tf-web-server" {
    subnet_id = aws_subnet.tf-public-subnet.id
    availability_zone = var.az2
    ami = var.ami
    key_name = var.key
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.tf-SG.id]
      tags = {
        Name = "${var.project_name}-webserver-server"
    }
    depends_on = [ aws_security_group.tf-SG ]
}