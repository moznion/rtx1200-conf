# Basic configuration
ip route default gateway pp 1
ip lan1 address 192.168.100.1/24

# IPv4 PPPoE configuration
pp select 1
 pp always-on on
 pppoe use lan2
 pppoe auto disconnect off
 pp auth accept pap chap
 pp auth myname <?= $_[0]->{ipv4_pppoe}->{user} ?> <?= $_[0]->{ipv4_pppoe}->{password} ?>
 ppp lcp mru on 1454
 ppp ipcp ipaddress on
 ppp ipcp msext on
 ip pp mtu 1454
 ip pp secure filter in 1020 1030 2000
 ip pp secure filter out 1010 1011 1012 1013 1014 1015 3000 dynamic 100 101 102
 103 104 105 106 107
 ip pp nat descriptor 1
 ip pp tcp mss limit auto
 pp enable 1

# Filter configuration
ip filter source-route on
ip filter directed-broadcast on
ip filter 1010 reject * * udp,tcp 135 *
ip filter 1011 reject * * udp,tcp * 135
ip filter 1012 reject * * udp,tcp netbios_ns-netbios_ssn *
ip filter 1013 reject * * udp,tcp * netbios_ns-netbios_ssn
ip filter 1014 reject * * udp,tcp 445 *
ip filter 1015 reject * * udp,tcp * 445
ip filter 1020 reject 192.168.100.0/24 *
ip filter 1030 pass * 192.168.100.0/24 icmp
ip filter 2000 reject * *
ip filter 3000 pass * *
ip filter dynamic 100 * * ftp
ip filter dynamic 101 * * www
ip filter dynamic 102 * * domain
ip filter dynamic 103 * * smtp
ip filter dynamic 104 * * pop3
ip filter dynamic 105 * * netmeeting
ip filter dynamic 106 * * tcp
ip filter dynamic 107 * * udp

# NAT configuration
nat descriptor type 1 masquerade
nat descriptor timer 1000 600
nat descriptor timer 1000 protocol=tcp port=www 120
nat descriptor timer 1000 protocol=tcp port=https 120

# DHCP configuration
dhcp service server
dhcp server rfc2131 compliant except remain-silent
dhcp scope 1 192.168.100.3-192.168.100.250/24

# DNS configuration
dns server pp 1
dns private address spoof on

# Misc
telnetd host lan1
httpd host lan1
upnp use on
sshd service off

