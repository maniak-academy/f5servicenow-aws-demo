# resource "aws_instance" "juiceshop" {
#   count                  = 1
#   instance_type          = "t2.micro"
#   ami                    = "ami-087c17d1fe0178315"
#   vpc_security_group_ids = [aws_security_group.juiceshop_sg.id]
#   subnet_id              = aws_subnet.mgmt.id
#   key_name               = "demokeyforaws"
#   user_data              = file("juice.sh")
#   associate_public_ip_address = true

#   root_block_device {
#     volume_size = "10"
#   }
#   tags = {
#     Name = "juiceshop"
#   }
# }


# resource "aws_security_group" "juiceshop_sg" {
#   name        = "juiceshop"
#   description = "Allow http and https inbound traffic"
#   vpc_id      = module.vpc.vpc_id

#   ingress {
#     description = "HTTPs"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]

#   }
#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]

#   }
#   ingress {
#     description = "ssh"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]

#   }
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

# module "AppDeploy" {
#   source = "github.com/sebbycorp/terraform-F5AS3-AppDeploy"
#   tenant               = "juiceshop"
#   as3tmpl              = "http"
#   common_name          = "juiceshop"
#   vip_address          =  "10.0.1.152"
#   pool_members_port    = "80"
#   monitor              = "tcp"
#   load_balancing_mode  = "least-connections-member"
#   pool_members         = [aws_instance.juiceshop[0].private_ip]
#   depends_on = [ module.bigip ]
# }


# resource "aws_route53_record" "securedemo_maniak_academy" {
#   zone_id = "Z08152651IEON21MZBRNJ"  # Replace with your Route 53 hosted zone ID
#   name    = "securedemo.maniak.academy"
#   type    = "A"
#   ttl     = 300
#   records = [module.bigip[0].mgmtPublicIP]  # Replace with the IP address for securedemo.maniak.academy
# }