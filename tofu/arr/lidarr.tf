resource "lidarr_root_folder" "music" {
  name                    = "Music"
  path                    = "/data/media/music"
  quality_profile_id      = 1
  metadata_profile_id     = 1
  monitor_option          = "all"
  new_item_monitor_option = "all"
}

resource "lidarr_download_client_qbittorrent" "qbittorrent" {
  enable                     = true
  priority                   = 1
  name                       = "qBittorrent"
  host                       = "qbittorrent.media.svc.cluster.local"
  port                       = 8080
  music_category             = "music"
  remove_completed_downloads = false
  remove_failed_downloads    = true
}

resource "lidarr_download_client_sabnzbd" "sabnzbd" {
  count                      = var.SABNZBD_API_KEY != "" ? 1 : 0
  enable                     = true
  priority                   = 1
  name                       = "SABnzbd"
  host                       = "sabnzbd.media.svc.cluster.local"
  port                       = 8080
  api_key                    = var.SABNZBD_API_KEY
  music_category             = "music"
  remove_completed_downloads = true
  remove_failed_downloads    = true
}
