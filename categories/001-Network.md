## NETWORK ##

### Network Interface Management ###

How the system sees network cards

#### 👉 Concept ####

* NICs (eth0, ens33, enp0s3)
* Virtual interfaces
* Loopback (lo)

#### Commands ####

```
ip link
ip addr
nmcli device
ethtool ens33
```

### IP Addressing & Routing ###

👉 How packets know where to go

#### Concepts ####

* IPv4 / IPv6
* Static vs DHCP
* Default gateway
* Routing table

#### Commands ####

```
ip addr show
ip route
nmcli connection show
nmcli connection modify
```

### DNS & Name Resolution ###

👉 How names become IPs

##### Concepts #####

* DNS resolution order
* resolv.conf
* hosts file

##### Commands #####

```
dig google.com
nslookup google.com
getent hosts myserver
```

#### Network Connectivity Testing ####

👉 Is the network working?

##### Commands #####

```
ping
traceroute
tracepath
mtr
```

#### Port & Service Testing ####

👉 Is a service reachable?

##### Commands #####

```
ss -tulnp
netstat -tulnp   # legacy
nc -zv host port
telnet host port
```

#### Network Monitoring & Debugging ####

👉 Deep troubleshooting

##### Commands #####
```
tcpdump
wireshark
ss
iftop
nload
```

#### Simple Mental Map (REMEMBER THIS) ####
```
Interface → IP → Route → DNS → Connectivity → Ports → Firewall → Services → Monitoring
```
