# LAN configuration
ip lan1 address 192.168.100.1/24
ip lan2 address dhcp
ip lan2 nat descriptor 1

# Network configuration
pp disable all
no tunnel enable all

# NAT configuration
nat descriptor type 1 masquerade
nat descriptor timer 1000 600
nat descriptor timer 1000 protocol=tcp port=www 120
nat descriptor timer 1000 protocol=tcp port=https 120
nat descriptor address outer 1 primary
nat descriptor address inner 1 auto
nat descriptor masquerade incoming 1 reject

# DHCP configuration
dhcp service server
dhcp server rfc2131 compliant except remain-silent
dhcp scope 1 192.168.100.3-192.168.100.250/24

# DNS configuration
dns server 8.8.8.8
dns server dhcp lan2

# misc
telnetd host lan1
httpd host lan1
upnp use on
sshd service off

