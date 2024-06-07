# Define the provider
provider "aws" {
  region = "us-west-2" # Replace with your desired region
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "My VPC"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My IGW"
  }
}

# Create Route Table
resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "My Route Table"
  }
}

# Create Subnet 1
resource "aws_subnet" "my_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-west-2a" # Replace with your desired AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "My Subnet 1"
  }
}



# Associate Subnet 1 with Route Table
resource "aws_route_table_association" "subnet1_rt_assoc" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_rt.id
}



# Create Security Group
resource "aws_security_group" "my_sg" {
  name_prefix = "my-sg-"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My Security Group"
  }
}

# Create Ansible Master
resource "aws_instance" "ansible_master" {
  ami                    = "ami-08116b9957a259459"
  instance_type          = "t2.medium"
  key_name               = "Oregon-Key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_subnet1.id
  associate_public_ip_address = true

 

  tags = {
    Name = "Ansible Master"
    Env = "Capstone Project"
  }
}

# Create Jenkins Master
resource "aws_instance" "jenkins_master" {
  ami                    = "ami-08116b9957a259459"
  instance_type          = "t2.medium"
  key_name               = "Oregon-Key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_subnet1.id
  associate_public_ip_address = true

 

  tags = {
    Name = "Jenkins Master"
    Env = "Capstone Project"
  }
}

# Create Testing Server
resource "aws_instance" "testing_server" {
  ami                    = "ami-08116b9957a259459"
  instance_type          = "t2.medium"
  key_name               = "Oregon-Key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_subnet1.id
  associate_public_ip_address = true


  tags = {
    Name = "Testing Server"
    Env = "Capstone Project"
  }
}

# Create Production Server
resource "aws_instance" "production_server" {
  ami                    = "ami-08116b9957a259459"
  instance_type          = "t2.medium"
  key_name               = "Oregon-Key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.my_subnet1.id
  associate_public_ip_address = true


  tags = {
    Name = "Production Server"
    Env = "Capstone Project"
  }
}

