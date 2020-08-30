# provider "scaleway" {
#   organization_id   = "e531300f-9e94-4009-ae22-bf544d07bf16"
#   secret_key        = "127d305b-0a5b-4bdb-8a25-cb9f3f96a572"
#   access_key        = "SCWX8F5BSPSC6JSB1AFC"
#   region            = "fr-par"
#   zone              = "fr-par-1"
# }

provider "scaleway" {
  organization_id   = "{var.SCALEWAY_ORGANIZATION}"
  secret_key        = "{var.SCALEWAY_API_ACCESS_KEY}"
  access_key        = "{var.SCALEWAY_API_TOKEN}"
  region            = "fr-par"
  zone              = "fr-par-1"
}


resource "scaleway_instance_ip" "ip" {
}

data "scaleway_image" "ubuntu-bionic" {
  architecture  = "x86_64"
  name          = "ubuntu-bionic"

}

resource "scaleway_instance_volume" "data" {
  size_in_gb = 20
  type = "l_ssd"
}

resource "scaleway_instance_server" "ubuntu-bionic-server" {
  name  = "dnsinfra-safenetapp"
  image = data.scaleway_image.ubuntu-bionic.id
  type  = "DEV1-S"

}


resource "scaleway_instance_security_group" "http" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"
}
resource "scaleway_instance_security_group" "dns" {
  name        = "dns"
  description = "allow dns traffic"
}


resource "scaleway_security_group_rule" "http_accept" {
  security_group = scaleway_instance_security_group.http.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = scaleway_instance_security_group.http.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}

resource "scaleway_security_group_rule" "tcp_dns_accept" {
  security_group = scaleway_instance_security_group.dns.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 53
}

resource "scaleway_security_group_rule" "udp_dns_accept" {
  security_group = scaleway_instance_security_group.dns.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "UDP"
  port      = 53
}
