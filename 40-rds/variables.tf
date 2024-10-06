variable "project_name" {
  default = "expence"
}
variable "environment" {
  default = "dev"
}
variable "common_tags" {
  default = {
    project_name = "expence"
    environment = "dev"
    terraform = "true"
  }
}


variable "rds_tags" {
    default = {
        Component = "mysql"
    }
}


variable "bastion_tags" {
    default = {
        Component = "bastion"
    }
}



variable "zone_name" {
  default = "hinatadream.online"
}