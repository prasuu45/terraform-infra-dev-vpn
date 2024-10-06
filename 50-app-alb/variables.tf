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





variable "app_alb_tags" {
    default = {
        Component = "app_alb"
    }
}

variable "zone_name" {
  default = "hinatadream.online"
}