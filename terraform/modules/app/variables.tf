variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable zone {
  description = "Set zone"
  default     = "europe-west2-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable source_ranges_puma {
  description = "Allowed IP addressed for app"
  default     = ["0.0.0.0/0"]
}
