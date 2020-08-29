provider "scaleway" {
  organization = ""
  token        = ""
  region       = "par1"
}

resource "scaleway_ip" "ip" {
}

data "scaleway_image" "ubuntu-bionic" {
  architecture = "x86_64"
  name         = "ubuntu-bionic"
}

resource "scaleway_instance_volume" "data" {
  size_in_gb = 20
  type = "l_ssd"
}

resource "scaleway_server" "ubuntu-bionic-server" {
  name  = "ubuntu-bionic-server"
  public_ip = scaleway_ip.ip.ip
  image = data.scaleway_image.ubuntu-bionic.id
  type  = "DEV1-S"

}


resource "scaleway_security_group" "http" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"
}
resource "scaleway_security_group" "dns" {
  name        = "dns"
  description = "allow dns traffic"
}


resource "scaleway_security_group_rule" "http_accept" {
  security_group = scaleway_security_group.http.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = scaleway_security_group.http.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}
resource "scaleway_security_group_rule" "tcp_dns_accept" {
  security_group = scaleway_security_group.dns.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 53
}
resource "scaleway_security_group_rule" "udp_dns_accept" {
  security_group = scaleway_security_group.dns.id

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "UDP"
  port      = 53
}
