#Day-1


#remote backend --- S3
terraform {
  backend "s3" {
    bucket = "terraform-backend-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    
  }
}


#Provider-Block
provider "aws" {
    region = "ap-south-1"
}


#resource-block ---EC2
#using count variable
/*
resource "aws_instance" "tf-server-1" {
    ami = "ami-0b910d1016287a5e7"
    instance_type = "t3.small"
    #To crearte multiple instaces at SAME TIME
    count = 3
    #Using existing security group that have been created manually
    vpc_security_group_ids = ["sg-06ec74401def8b075", "sg-0fa57c9479dcdc968"]
    key_name = "xyz-key"
    tags = {
        Name = "server-${count.index}"
    }  
}


#using for_each variable
resource "aws_instance" "tf-server-1" {
    ami = "ami-0b910d1016287a5e7"
    instance_type = "t3.small"
    #To crearte multiple instaces at SAME TIME
    #count = 3
    #for_each = toset[ "webserver", "appserver", "dbserver" ]
    for_each = tomap({
        app = "appserver"
        web = "webserver"
        db = "dbserver"
            })
    #Using existing security group that have been created manually
    vpc_security_group_ids = ["sg-06ec74401def8b075", "sg-0fa57c9479dcdc968"]
    key_name = "xyz-key"
    tags = {
        Name = "each"
    }  
}



# task Day 1
resource "aws_instance" "tf-server-1" {
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    #To crearte multiple instaces at SAME TIME
    #count = 3
    for_each = toset(["app-1", "db-1", "web-1"])
    #for_each = tomap({
    #    app = "appserver"
    #   web = "webserver"
    #   db = "dbserver"
    #        })
    #Using existing security group that have been created manually
    vpc_security_group_ids = ["sg-06ec74401def8b075"]
    key_name = "terraform-key"
    tags = {
        Name = "each"
    }  
}


#Day 2
resource "aws_instance" "tf-server-2" {
    ami = "ami-0b910d1016287a5e7"
    instance_type = "t3.micro"
    key_name = "devops-key"
# Use security group created by terraform
    vpc_security_group_ids = [aws_security_group.tf-SG.id]     #refer the terraform resources
    tags = {
        Name = "server-2"
    }
}

# resource -- to crearte security group
resource "aws_security_group" "tf-SG" {
    name = "my-sg"
    vpc_id = "vpc-0ea0e58132290a92b"
# Define inbound rule
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
        description = "alow https"
        to_port = 443
        from_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
# define outbound rules
    egress {
        description = "alllow all traffic"
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    lifecycle {
    create_before_destroy = false 
    }
}



#day 3
#Variable

resource "aws_instance" "tf-server-3" {
    ami = "ami-0b910d1016287a5e7"
    instance_type = "t3.micro"
    key_name = "devops-key"
    tags = {
        Name = "web-3"
    }

  
}


#Day 4
resource "aws_instance" "tf-server-4" {
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key
    availability_zone = var.az
    tags = {
        Name = "web-4"
    }

  
}

# add data script
resource "aws_instance" "tf-server-4" {
    ami = var.ami
    instance_type = var.instance_type 
    key_name = var.key
    availability_zone = var.az
    user_data = <<-EOF
                #!/bin/bash
                yum update
                cd user/share/html
                echo "<h1>we have to put commands here I am just using echo</h1>" >index.html
                EOF
    tags = {
        Name = "web-4"
    }
}
*/
#Day 5
resource "aws_instance" "tf-web-5" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key
    availability_zone = var.az
    tags = {
        Name = "web-4"
    }
}