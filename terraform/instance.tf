provider "aws" {
    region = "us-east-1"
    access_key ="AKIASE5KRGE4ZFBVILTM"
    secret_key ="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"
}


resource "aws_instance" "admin" {
    ami = "ami-0df8c184d5f6ae949"
    instance_type = "t2.medium"
    security_groups = [ "default" ]
    key_name = "147"
    root_block_device {
      volume_size = 20
      volume_type = "gp2"
      delete_on_termination = true
    }
    tags = {
      Name = "Admin-server"
    }

}
