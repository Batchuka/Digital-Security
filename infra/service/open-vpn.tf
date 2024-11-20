# infra\service\open-vpn.tf

resource "aws_instance" "openvpn_server" {
  ami                     = "ami-0e86e20dae9224db8"  # Amazon Ununtu 24.04
  instance_type           = "t2.small"
  key_name                = "open-vpn"
  subnet_id               = var.idmz_subnet_id
  vpc_security_group_ids  = [var.idmz_sg_id]

  tags = {
    Name = "OpenVPN-Server"
  }

  user_data = file("service\\open_vpn\\openvpn-install.sh")
}
