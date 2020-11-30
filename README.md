# terraform-module-cloudflare-route53

This Terraform module works by unifying the interface to create and manage DNS
records. It helps increase DNS redundancy by keeping records across two
providers without any need for replication.

## Note

While this is a Terraform module, you still need to set the
default variable value for [`zone_map`](https://github.com/jacobbednarz/terraform-module-cloudflare-route53/blob/5f26e8e92301f0af13982e0172bf17c760069339/main.tf#L1-L8) for your Cloudflare zone IDs and Route53
hosted zones. This is due to how variables are referenced and initialised and
without a default value, the `lookup` doesn't work correctly. :fingers_crossed:
future Terraform versions fix this and it becomes possible to configure this on
the CLI.

## Example usage

Below we create two records that will be created and managed in both providers.

```hcl
variable "cloudflare_api_token" {}
variable "cloudflare_zone_id" {}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-east-1"
}

module "example_cname" {
  zone_id  = var.cloudflare_zone_id
  name     = "notreal"
  value    = "example.com"
  type     = "CNAME"
  ttl      = 300
  proxied  = false
}

module "example_txt" {
  zone_id  = var.cloudflare_zone_id
  name     = "_verify_something"
  value    = "some txt verification"
  type     = "TXT"
  ttl      = 60
}
```
