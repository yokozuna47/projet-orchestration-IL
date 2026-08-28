variable "prefixe" {
  type    = string
  default = "yokozuna"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "compte_id" {
  type    = string
  default = "734391586315"
}

variable "vpc_id" {
  type    = string
  default = "vpc-05a1263b45443f517"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-0450c453c15f5ab9e", "subnet-0187024ea960fa8a6"]
}

variable "image_tag" {
  type    = string
  default = "1.0.0"
}

variable "desired_count" {
  type    = number
  default = 2
}
