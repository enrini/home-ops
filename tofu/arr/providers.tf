provider "prowlarr" {
  url     = "http://prowlarr.media.svc.cluster.local:9696"
  api_key = var.PROWLARR_API_KEY
}

provider "radarr" {
  url     = "http://radarr.media.svc.cluster.local:7878"
  api_key = var.RADARR_API_KEY
}

provider "sonarr" {
  url     = "http://sonarr.media.svc.cluster.local:8989"
  api_key = var.SONARR_API_KEY
}

provider "sonarr" {
  alias   = "anime"
  url     = "http://sonarr-anime.media.svc.cluster.local:8989"
  api_key = var.SONARR_ANIME_API_KEY
}

provider "lidarr" {
  url     = "http://lidarr.media.svc.cluster.local:8686"
  api_key = var.LIDARR_API_KEY
}

provider "restapi" {
  alias                = "lidarr"
  uri                  = "http://lidarr.media.svc.cluster.local:8686"
  write_returns_object = true
  id_attribute         = "id"
  headers = {
    "Content-Type" = "application/json"
    "X-Api-Key"    = var.LIDARR_API_KEY
  }
}
