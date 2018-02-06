variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west2"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key {
  description = "Connect private key"
}

variable zone {
  description = "Set zone"
  default     = "europe-west2-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable source_ranges {
  description = "Allowed IP addressed"
  default     = ["0.0.0.0/0"]
}

variable source_ranges_puma {
  description = "Allowed IP addressed for puma"
  default     = ["0.0.0.0/0"]
}
