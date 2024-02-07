resource "aws_instance" "midserver" {
  count                  = 1
  instance_type          = "t2.micro"
  ami                    = "ami-087c17d1fe0178315"
  vpc_security_group_ids = [aws_security_group.midserver_sg.id]
  subnet_id              = aws_subnet.mgmt.id
  key_name               = "demokeyforaws"
  user_data              = file("midserver.sh")
  associate_public_ip_address = true

  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name = "midserver"
  }
}


resource "aws_security_group" "midserver_sg" {
  name        = "midserver"
  description = "Allow http and https inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


# module "AppDeploy" {
#   source = "github.com/sebbycorp/terraform-F5AS3-AppDeploy"
#   tenant               = "midserver"
#   as3tmpl              = "http"
#   common_name          = "midserver"
#   vip_address          =  "10.0.1.152"
#   pool_members_port    = "80"
#   monitor              = "tcp"
#   load_balancing_mode  = "least-connections-member"
#   pool_members         = [aws_instance.midserver[0].private_ip]
#   depends_on = [ module.bigip ]
# }

