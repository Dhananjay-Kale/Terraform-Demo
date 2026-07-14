resource "aws_instance" "tf-web-5" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key
    availability_zone = var.az
    tags = {
        Name = "web-4"
    }
}