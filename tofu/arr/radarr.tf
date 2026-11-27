resource "radarr_root_folder" "movies" {
  path = "/data/media/movies"
}

resource "radarr_download_client_qbittorrent" "qbittorrent" {
  enable                     = true
  priority                   = 1
  name                       = "qBittorrent"
  host                       = "qbittorrent.media.svc.cluster.local"
  port                       = 8080
  movie_category             = "movies"
  remove_completed_downloads = false
  remove_failed_downloads    = true
}

resource "radarr_download_client_sabnzbd" "sabnzbd" {
  count                      = var.SABNZBD_API_KEY != "" ? 1 : 0
  enable                     = true
  priority                   = 1
  name                       = "SABnzbd"
  host                       = "sabnzbd.media.svc.cluster.local"
  port                       = 8080
  api_key                    = var.SABNZBD_API_KEY
  movie_category             = "movies"
  remove_completed_downloads = true
  remove_failed_downloads    = true
}
