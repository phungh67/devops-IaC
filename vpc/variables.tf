variable "vpc_parameters" {
  description = "Parameters for VPC creation"
  type = map(object({
    cidr_block          = string
    enable_dns_supprot  = optional(bool, true)
    enable_dns_hostname = optional(bool, true)
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "subnet_parameters" {
  description = "Parameters for subnets creation"
  type = map(object({
    cidr_block = string
    vpc_name   = string
    tags       = optional(map(string), {})
  }))
  default = {}
}

variable "igw_parameters" {
  description = "Parameters for IGW creation"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "route_table_parameters" {
  description = "Parameters for route table creation"
  type = map(object({
    vpc_name = string
    tags     = optional(string, {})
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool, true)
      gateway_id = string
    })), [])
  }))
  default = {}
}

variable "route_table_association_parameters" {
  description = "Parameters for route table creation"
  type = map(object({
    subnet_name      = string
    route_table_name = string
  }))
  default = {}
}
