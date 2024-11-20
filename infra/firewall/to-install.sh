#!/bin/bash

# Habilitar o IP forwarding
echo "Habilitando IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p

# Configurar o IPTables para mascaramento (NAT)
echo "Configurando IPTables para mascaramento..."
sudo iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE  # Supondo que eth1 é a interface que conecta à internet
sudo iptables -t nat -A PREROUTING -p udp --dport 1194 -j DNAT --to-destination 172.31.2.237:1194

# Salvar as regras do IPTables
echo "Salvando as regras do IPTables..."
sudo apt-get update
sudo apt-get install -y iptables-persistent

sudo netfilter-persistent save
sudo netfilter-persistent reload

echo "Configurações aplicadas com sucesso."