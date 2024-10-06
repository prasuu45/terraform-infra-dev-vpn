module "vpc" {
    source = "git::https://github.com/prasuu45/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    public-subnet_cidrs = var.public_subnet_cidrs
    private-subnet_cidrs = var.private_subnet_cidrs
    database-subnet_cidrs = var.database_subnet_cidrs
    is_peering_required = true

  
}

