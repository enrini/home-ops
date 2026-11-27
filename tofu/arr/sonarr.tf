resource "sonarr_root_folder" "tv" {
  path = "/data/media/tv"
}

resource "sonarr_download_client_qbittorrent" "tv" {
  enable                     = true
  priority                   = 1
  name                       = "qBittorrent"
  host                       = "qbittorrent.media.svc.cluster.local"
  port                       = 8080
  tv_category                = "tv"
  remove_completed_downloads = false
  remove_failed_downloads    = true
}

resource "sonarr_download_client_sabnzbd" "tv" {
  count                      = var.SABNZBD_API_KEY != "" ? 1 : 0
  enable                     = true
  priority                   = 1
  name                       = "SABnzbd"
  host                       = "sabnzbd.media.svc.cluster.local"
  port                       = 8080
  api_key                    = var.SABNZBD_API_KEY
  tv_category                = "tv"
  remove_completed_downloads = true
  remove_failed_downloads    = true
}

resource "sonarr_root_folder" "anime" {
  provider = sonarr.anime
  path     = "/data/media/anime"
}

resource "sonarr_download_client_qbittorrent" "anime" {
  provider                   = sonarr.anime
  enable                     = true
  priority                   = 1
  name                       = "qBittorrent"
  host                       = "qbittorrent.media.svc.cluster.local"
  port                       = 8080
  tv_category                = "anime"
  remove_completed_downloads = false
  remove_failed_downloads    = true
}

resource "sonarr_download_client_sabnzbd" "anime" {
  provider                   = sonarr.anime
  count                      = var.SABNZBD_API_KEY != "" ? 1 : 0
  enable                     = true
  priority                   = 1
  name                       = "SABnzbd"
  host                       = "sabnzbd.media.svc.cluster.local"
  port                       = 8080
  api_key                    = var.SABNZBD_API_KEY
  tv_category                = "anime"
  remove_completed_downloads = true
  remove_failed_downloads    = true
}
