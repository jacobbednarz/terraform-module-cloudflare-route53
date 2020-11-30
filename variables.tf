
variable "zone_id" {
  type        = string
  description = "Cloudflare zone ID to use for resources and lookups"
}

variable "name" {
  type        = string
  description = "DNS record name"
}

variable "type" {
  type        = string
  description = "DNS record type"
  validation {
    condition     = contains(["A", "AAAA", "CNAME", "TXT"], var.type)
    error_message = "DNS record type must be A, AAAA, CNAME or TXT."
  }
}

variable "value" {
  type        = string
  description = "DNS record value"
}

variable "proxied" {
  description = "Whether the record should be proxied in Cloudflare"
  type        = bool
  default     = false
}

variable "ttl" {
  type        = string
  description = "DNS record TTL"
}

variable "zone_map" {
  type        = map(string)
  description = "Map of string values of Cloudflare zone ID to Route53 zone ID"
}
