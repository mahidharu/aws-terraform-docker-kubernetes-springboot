resource "aws_instance" "example" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}