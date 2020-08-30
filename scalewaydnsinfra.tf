variable "organization_id" {
    type = string
}

variable "secret_key" {
    type = string
}

variable "access_key" {
    type = string
}

provider "scaleway" {
  organization_id   = var.organization_id
  secret_key        = var.secret_key
  access_key        = var.access_key
  region            = "fr-par"
  zone              = "fr-par-1"
}


resource "scaleway_instance_ip" "public_ip" {
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
  tags = [ "dnsadholes", "safenetapp", "sensely" ]
  security_group_id = scaleway_instance_security_group.www.id
  ip_id = scaleway_instance_ip.public_ip.id

}


resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
    # trying to specigy 0.0.0.0 makes ssh not accept connection
    # ip     = "0.0.0.0"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }

  inbound_rule {
    action = "accept"
    port   = "53"
  }
}
