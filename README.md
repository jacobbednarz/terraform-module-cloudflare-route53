# terraform-module-cloudflare-route53

This Terraform module works by unifying the interface to create and manage DNS
records. It helps increase DNS redundancy by keeping records across two
providers without any need for replication.

## Example usage

Below we create two records that will be created and managed in both providers.

```hcl
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}
variable "zone_map" {}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-east-1"
}

module "example_cname" {
  source   = "path/to/this/module"
  zone_map = var.zone_map

  zone_id  = var.cloudflare_zone_id
  name     = "notreal"
  value    = "example.com"
  type     = "CNAME"
  ttl      = 300
  proxied  = false
}

module "example_txt" {
  source   = "path/to/this/module"
  zone_map = var.zone_map

  zone_id  = var.cloudflare_zone_id
  name     = "_verify_something"
  value    = "some txt verification"
  type     = "TXT"
  ttl      = 60
}
```

**Applying changes**

```
$ TF_VAR_zone_map='{"7b8373630de363bb741cfa71deadb33f"="Z081478729JWF3A63XVUY"}' \
  TF_VAR_cloudflare_api_token=xxxxxx \
  TF_VAR_cloudflare_zone_id=xxxxxx \
  terraform apply
```
