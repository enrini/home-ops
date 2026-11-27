resource "lidarr_root_folder" "music" {
  name                    = "Music"
  path                    = "/data/media/music"
  quality_profile_id      = 1
  metadata_profile_id     = 1
  monitor_option          = "all"
  new_item_monitor_option = "all"
}

# Managed via Mastercard/restapi due to devopsarr/terraform-provider-lidarr#255
# (Lidarr v3 returns TorrentDownloadProtocol/UsenetDownloadProtocol on /api/v1/downloadclient).
resource "terraform_data" "lidarr_qbittorrent_spec" {
  input = {
    host           = "qbittorrent.media.svc.cluster.local"
    port           = 8080
    music_category = "music"
  }
}

resource "restapi_object" "lidarr_qbittorrent" {
  provider                  = restapi.lidarr
  path                      = "/api/v1/downloadclient"
  id_attribute              = "id"
  ignore_all_server_changes = true

  data = jsonencode({
    enable                   = true
    protocol                 = "torrent"
    priority                 = 1
    name                     = "qBittorrent"
    implementation           = "QBittorrent"
    configContract           = "QBittorrentSettings"
    removeCompletedDownloads = false
    removeFailedDownloads    = true
    tags                     = []
    fields = [
      { name = "host", value = "qbittorrent.media.svc.cluster.local" },
      { name = "port", value = 8080 },
      { name = "useSsl", value = false },
      { name = "urlBase", value = "" },
      { name = "username", value = "" },
      { name = "password", value = "" },
      { name = "musicCategory", value = "music" },
      { name = "musicImportedCategory", value = "" },
      { name = "recentMusicPriority", value = 0 },
      { name = "olderMusicPriority", value = 0 },
      { name = "initialState", value = 0 },
      { name = "sequentialOrder", value = false },
      { name = "firstAndLast", value = false },
      { name = "contentLayout", value = 0 },
    ]
  })

  lifecycle {
    ignore_changes       = [data]
    replace_triggered_by = [terraform_data.lidarr_qbittorrent_spec]
  }
}

resource "terraform_data" "lidarr_sabnzbd_spec" {
  count = var.SABNZBD_API_KEY != "" ? 1 : 0
  input = {
    host           = "sabnzbd.media.svc.cluster.local"
    port           = 8080
    music_category = "music"
    api_key_hash   = sha256(var.SABNZBD_API_KEY)
  }
}

resource "restapi_object" "lidarr_sabnzbd" {
  provider                  = restapi.lidarr
  count                     = var.SABNZBD_API_KEY != "" ? 1 : 0
  path                      = "/api/v1/downloadclient"
  id_attribute              = "id"
  ignore_all_server_changes = true

  data = jsonencode({
    enable                   = true
    protocol                 = "usenet"
    priority                 = 1
    name                     = "SABnzbd"
    implementation           = "Sabnzbd"
    configContract           = "SabnzbdSettings"
    removeCompletedDownloads = true
    removeFailedDownloads    = true
    tags                     = []
    fields = [
      { name = "host", value = "sabnzbd.media.svc.cluster.local" },
      { name = "port", value = 8080 },
      { name = "useSsl", value = false },
      { name = "urlBase", value = "" },
      { name = "apiKey", value = var.SABNZBD_API_KEY },
      { name = "username", value = "" },
      { name = "password", value = "" },
      { name = "musicCategory", value = "music" },
      { name = "recentMusicPriority", value = 0 },
      { name = "olderMusicPriority", value = 0 },
    ]
  })

  lifecycle {
    ignore_changes       = [data]
    replace_triggered_by = [terraform_data.lidarr_sabnzbd_spec[0]]
  }
}
