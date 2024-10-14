variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
  default = "hinatadream.online"
}

variable "zone_id" {
    default = "Z07409041PWOSBWZS3KAV"
}