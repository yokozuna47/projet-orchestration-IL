variable "namespace" {
  type    = string
  default = "projet"
}

variable "image" {
  type    = string
  default = "nginxdemos/hello:plain-text"
}

variable "replicas" {
  type    = number
  default = 3
}

variable "hote_ingress" {
  type    = string
  default = "projet.local"
}
