provider "aws" {
    region = "us-east-1"
    access_key = "AKIASE5KRGE4ZFBVILTM"
    secret_key = "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"
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16" 
    tags = {
        Name = "Vpc-by-terraform"
    }    
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Subnet-by-terraform"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id   
    tags ={
        Name = "Internet-gw-by-terraform"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "Route table by terraform"
    }
  
}

resource "aws_route_table_association" "subnet_association" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.route_table.id
}


resource "aws_instance" "ec2" {
    ami = "ami-0df8c184d5f6ae949"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet.id
    key_name = "147"
    associate_public_ip_address = true

    tags = {
      Name = "Ec2-by-terraform"
    }

    root_block_device {
      volume_size = 15
      volume_type = "gp2"
      delete_on_termination = true
    }

}
