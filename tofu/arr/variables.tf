variable "PROWLARR_API_KEY" {
  type      = string
  sensitive = true
}

variable "RADARR_API_KEY" {
  type      = string
  sensitive = true
}

variable "SONARR_API_KEY" {
  type      = string
  sensitive = true
}

variable "SONARR_ANIME_API_KEY" {
  type      = string
  sensitive = true
}

variable "LIDARR_API_KEY" {
  type      = string
  sensitive = true
}

variable "SABNZBD_API_KEY" {
  type      = string
  sensitive = true
  default   = ""
}

variable "NAVIDROME_USERNAME" {
  type      = string
  sensitive = true
  default   = ""
}

variable "NAVIDROME_PASSWORD" {
  type      = string
  sensitive = true
  default   = ""
}
