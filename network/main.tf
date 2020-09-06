module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 2.5"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "public"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
      description   = "The public subnet"
    },
    {
      subnet_name           = "private"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "The private subnet"
    }
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

# Firewall
resource "google_compute_firewall" "personal_access" {
  name          = "restricted-ingress"
  network       = module.vpc.network_name
  source_ranges = ["67.180.232.183/32"]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000", "443", "22"]
  }
}