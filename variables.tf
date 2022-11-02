variable "config" {
  description = "ECS container definition configuration"
  type        = map(any)
  default     = {}
}

variable "extra_tags" {
  description = "Additional tags to associate"
  type        = map(string)
  default     = {}
}
