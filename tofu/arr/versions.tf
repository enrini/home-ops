terraform {
  required_version = ">= 1.6.0"

  required_providers {
    prowlarr = {
      source  = "devopsarr/prowlarr"
      version = "~> 3.2"
    }
    radarr = {
      source  = "devopsarr/radarr"
      version = "~> 2.5"
    }
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "~> 3.6"
    }
    lidarr = {
      source  = "devopsarr/lidarr"
      version = "~> 1.13"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = "~> 1.20"
    }
  }
}
