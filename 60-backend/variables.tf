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
variable "backend_tags" {
    default = {
        Component = "backend"
    }
}

variable "zone_name" {
  default = "hinatadream.online"
}