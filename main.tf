terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "tomcat_permgen_or_metaspace_usage_exceeds_90" {
  source    = "./modules/tomcat_permgen_or_metaspace_usage_exceeds_90"

  providers = {
    shoreline = shoreline
  }
}