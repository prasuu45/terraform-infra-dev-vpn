module "mysql_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "mysql"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.mysql_sg_tags
    
}
module "backend_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "backend"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.backend_sg_tags
    
}
module "frontend_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "frontend"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.frontend_sg_tags
    
}
module "bastion_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "bastion"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.bastion_sg_tags
    
}
# module "ansible_sg" {
#     source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     sg_name = "ansible"
#     vpc_id = local.vpc_id
#     common_tags = var.common_tags
#     sg_tags = var.ansible_sg_tags
    
# }

module "app_alb_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "app_alb"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.app_alb_sg_tags
    
}

module "vpn_sg" {
    source = "git::https://github.com/prasuu45/aws-security-group.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = "vpn"
    vpc_id = local.vpc_id
    common_tags = var.common_tags
    sg_tags = var.app_alb_sg_tags
    
}
resource "aws_security_group_rule" "mysql-backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id =module.backend_sg.id
  security_group_id = module.mysql_sg.id
}
resource "aws_security_group_rule" "backend-frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id =module.frontend_sg.id
  security_group_id = module.backend_sg.id
}
resource "aws_security_group_rule" "frontend-public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.frontend_sg.id
}
resource "aws_security_group_rule" "bastion-mysql" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.mysql_sg.id
  security_group_id = module.bastion_sg.id
}
resource "aws_security_group_rule" "bastion-backend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.backend_sg.id
  security_group_id = module.bastion_sg.id
}
resource "aws_security_group_rule" "bastion-frontend" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.frontend_sg.id
  security_group_id = module.bastion_sg.id
}

resource "aws_security_group_rule" "bastion-public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg.id
}

# resource "aws_security_group_rule" "ansible-mysql" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id =module.mysql_sg.id
#   security_group_id = module.ansible_sg.id
# }
# resource "aws_security_group_rule" "ansible-backend" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id =module.backend_sg.id
#   security_group_id = module.ansible_sg.id
# }
# resource "aws_security_group_rule" "ansible-frontend" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   source_security_group_id =module.frontend_sg.id
#   security_group_id = module.ansible_sg.id
# }

# resource "aws_security_group_rule" "ansible-public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = module.ansible_sg.id
# }
resource "aws_security_group_rule" "backend-app_alb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.app_alb_sg.id
  security_group_id = module.backend_sg.id
}

resource "aws_security_group_rule" "app_alb-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.app_alb_sg.id
  security_group_id = module.bastion_sg.id
}

resource "aws_security_group_rule" "vpn-public-22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
resource "aws_security_group_rule" "vpn-public-443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}
resource "aws_security_group_rule" "vpn-public-943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}

resource "aws_security_group_rule" "vpn-public-1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.id
}

resource "aws_security_group_rule" "app_alb-vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id =module.vpn_sg.id
  security_group_id = module.app_alb_sg.id
}

resource "aws_security_group_rule" "backend-vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id =module.vpn_sg.id
  security_group_id = module.backend_sg.id
}

resource "aws_security_group_rule" "backend-vpn-8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id =module.vpn_sg.id
  security_group_id = module.backend_sg.id
}