provider "cloudflare" {
  alias = "dev_access"
  api_token = var.cloudflare_api_token
}

variable "domain" {
	default = "test-portfolio.bhanuprasad.in"
}

data "cloudflare_zone" "test_zone" {
	provider = cloudflare.dev_access
	name="bhanuprasad.in"
}

resource "cloudflare_access_application" "cf_app" {
	provider = cloudflare.dev_access
	for_each = {
		in = {
			name = "bhanuprasad in "
			zone_id = data.cloudflare_zone.test_zone.id
			domain = var.domain
		}
	}
	zone_id = each.value.zone_id
	name = each.value.name
	domain = each.value.domain
	session_duration = "${7 *24}h"  
}

resource "cloudflare_access_policy" "dev_access_policy" {
	provider = cloudflare.dev_access
	for_each = cloudflare_access_application.cf_app
	application_id = each.value.id 
	zone_id = each.value.zone_id
	name = "policy"
	precedence = 1
	decision = "allow"
	include {
		email = ["bhanuprasadcherukuvada2000@gmail.com"]
	}  
}

