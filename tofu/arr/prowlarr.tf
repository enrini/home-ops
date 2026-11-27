resource "prowlarr_tag" "byparr" {
  label = "byparr"
}

resource "prowlarr_indexer_proxy_flaresolverr" "byparr" {
  name            = "Byparr"
  host            = "http://byparr.media.svc.cluster.local:8191/"
  request_timeout = 60
  tags            = [prowlarr_tag.byparr.id]
}

resource "prowlarr_application_radarr" "radarr" {
  name            = "Radarr"
  sync_level      = "fullSync"
  base_url        = "http://radarr.media.svc.cluster.local:7878"
  prowlarr_url    = "http://prowlarr.media.svc.cluster.local:9696"
  api_key         = var.RADARR_API_KEY
  sync_categories = [2000, 2010, 2020, 2030, 2040, 2045, 2050, 2060, 2070, 2080]
}

resource "prowlarr_application_sonarr" "sonarr" {
  name            = "Sonarr"
  sync_level      = "fullSync"
  base_url        = "http://sonarr.media.svc.cluster.local:8989"
  prowlarr_url    = "http://prowlarr.media.svc.cluster.local:9696"
  api_key         = var.SONARR_API_KEY
  sync_categories = [5000, 5010, 5020, 5030, 5040, 5045, 5050, 5090]
}

resource "prowlarr_application_sonarr" "sonarr_anime" {
  name                  = "Sonarr Anime"
  sync_level            = "fullSync"
  base_url              = "http://sonarr-anime.media.svc.cluster.local:8989"
  prowlarr_url          = "http://prowlarr.media.svc.cluster.local:9696"
  api_key               = var.SONARR_ANIME_API_KEY
  sync_categories       = [5070]
  anime_sync_categories = [5070]
}

resource "prowlarr_application_lidarr" "lidarr" {
  name            = "Lidarr"
  sync_level      = "fullSync"
  base_url        = "http://lidarr.media.svc.cluster.local:8686"
  prowlarr_url    = "http://prowlarr.media.svc.cluster.local:9696"
  api_key         = var.LIDARR_API_KEY
  sync_categories = [3000, 3010, 3020, 3030, 3040, 3050, 3060]
}
