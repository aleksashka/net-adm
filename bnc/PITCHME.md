## Basic <br> Networking <br> Course
Note:
vim: set syntax=markdown colorcolumn=49:

+++

### Introduction
@ul
- No prerequisites
- Course includes:
  - IPv4, IPv6, Ethernet, Wireless, QoS
  - Applications: DHCP, DNS, NTP, SNMP, Syslog, (T)FTP, Telnet, SSH
  - Switching: VLANs, STP, EtherChannel, Port Security, DHCP Snooping, DAI
  - Routing: Static IPv4/IPv6, OSPF IPv4
  - Automation: Controller, APIs, data encoding
@ulend

+++

### Network components
@ul
- Routers
- Switches
- L3 Switches
- Access points
- Security devices (FW, IPS)
- Controllers
- Endpoints
- Servers (virtualization principles)
@ulend

+++

### Network topology architectures
@ul
- 2-tier (Distribution, Access)
- 3-tier (Core, Distribution, Access)
- Spine-leaf
- WAN
- SOHO
- On-premises vs cloud
@ulend

+++

@snap[north]
### Network characteristics
@snapend
@snap[west]
@ul
- #### Physical topologies
  - Bus
  - Star
  - Ring
  - Partial mesh
  - Full mesh
@ulend
@snapend
@snap[east]
@ul
- #### Logical topologies
  - Bus
  - Star
  - Ring
@ulend
@snapend
@snap[south]
@ul
- Reliability
- Availability
- Scalability
@ulend
@snapend

+++

### Network protocols
@ul
- [Internet Protocol][IP]
- [Ethernet][Eth]
- [Address Resolution Protocol][ARP]
- [Domain Name System][DNS]
- [Dynamic Host Configuration Protocol][DHCP]
- [Open Shortest Path First][OSPF]
@ulend
[IP]: https://en.wikipedia.org/wiki/Internet_Protocol
[Eth]: https://en.wikipedia.org/wiki/Ethernet
[ARP]: https://en.wikipedia.org/wiki/Address_Resolution_Protocol
[DNS]: https://en.wikipedia.org/wiki/Domain_Name_System
[DHCP]: https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol
[OSPF]: https://en.wikipedia.org/wiki/Open_Shortest_Path_First

+++

### Communications Models
@snap[center]
```text
| # |  OSI Model   |  TCP/IP Stack  |
+---+--------------+----------------+
| 7 | Application  | Application    |
| 6 | Presentation |                |
| 5 | Session      |                |
| 4 | Transport    | Transport      |
| 3 | Network      | Internet       |
| 2 | Data Link    | Network Access |
| 1 | Physical     |                |
```
@[1-2]
@[1-5]
@[1-6]
@[1-7]
@[1-8]
@[1-9]
@snapend

---

## Basics of IP

+++

### Conversion
@ul
- There are 10 types of people in the world. Those who understand binary and those who don’t.
- Counting from 0 to 100 in decimal
- Counting from 0 to 16 in binary
- Convert from binary to decimal
- Convert from decimal to binary
@ulend

+++

### IP, IP Address and Mask
@ul
- [RFC791](https://tools.ietf.org/html/rfc791)
- IP Address and Mask:
  - 32 bit length
    - `01000000111010011010010110001011`
  - 4 octets
    - `01000000 11101001 10100101 10001011`
  - converted to decimal
  - delimited with dot '.'
    - `64.233.165.139`
@ulend

+++

### IP and Mask
@ul
- Mask delimits network bits and host bits
- `216.218.186.2/24`
  - `11011000.11011010.10111010.00000010`
  - `11111111.11111111.11111111.00000000`
- `216.218.186.2 255.255.255.0`
  - `11011000.11011010.10111010.00000000`
  - `11011000.11011010.10111010.00000001`
  - `11011000.11011010.10111010.11111110`
  - `11011000.11011010.10111010.11111111`
@ulend

Note:

Practice: Convert multiple numbers between decimal and binary systems

+++

### IP and Mask
@ul
- Mask delimits network bits and host bits
- `216.218.186.2/24`
  - `216.218.186.0` - network address
  - `216.218.186.1` - first address
  - `216.218.186.254` - last address
  - `216.218.186.255` - broadcast address
- Formula to find number of addresses based on number of host bits
@ulend

Note:

Calculate boundaries of several classful networks

+++

### Configuring IP Addresses
@ul
- Windows
  - Start > Settings > Network & Internet > Ethernet > Select network > IP Assignment > Edit
- Linux config is distribution-specific
- Cisco router:
  - `Router(config-if)# ip address 216.218.186.2 255.255.255.0`
- All IP addresses are bound to the broadcast domain
- IP network <=> Broadcast domain
@ulend

+++

### Checking IP Addresses
@ul
- Windows:
  - `ipconfig`
- Linux:
  - `ifconfig`
- Cisco router:
  - `Router# show ip interface brief`
  - `Interface IP-Address Sts Protocol`
  - `Gig0/0 216.218.186.2 up up`
@ulend

+++

### Cisco IOS
@ul
- Cisco Internetwork Operating System
- Runs on many Cisco routers and switches
- Same look and feel among different models
- Uses [Command-line interface](https://en.wikipedia.org/wiki/Command-line_interface)
- Has several [modes](https://www.cisco.com/E-Learning/bulk/public/tac/cim/cib/using_cisco_ios_software/02_cisco_ios_hierarchy.htm):
  - User EXEC mode: `Router>`
  - Privileged EXEC mode: `Router#`
  - Global configuration mode: `Router(config)#`
  - Sub-configuration modes (interface, line, etc).
@ulend

+++

### Working with IOS
First, [connect](https://www.cisco.com/c/en/us/td/docs/routers/access/800/hardware/installation/guide/800HIG/connecting.html#25893) to console port, then open [terminal](https://www.cisco.com/c/en/us/support/docs/smb/switches/cisco-small-business-300-series-managed-switches/smb4984-access-the-cli-via-putty-using-a-console-connection-on-300-a.html) with [correct settings](https://www.cisco.com/c/en/us/support/docs/dial-access/asynchronous-connections/9321-terminal-settings.html#solution) (9600,8,N,1) and press Enter
```text
Router>enable
Router#configure terminal
Router(config)#hostname R
R(config)#interface Ethernet0/0
R(config-if)#ip address 172.16.1.1 255.255.0.0
R(config-if)#no shutdown
R(config-if)#end
R#
```
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]

+++

### Configurations
```text
#show startup-config
#show running-config
#show running-config int eth0/0
#show running-config [ int eth0/0 ]
#copy running-config startup-config
#ping 172.16.1.1
#ping 172.16.1.2
#show ip interface [ brief ]
```
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]

+++

### Types of IP Addresses
@ul
- Localhost: Local communication only (127.0.0.0/8)
- Unicast: One-to-one communication (e.g. 10.1.1.1)
- Multicast: One-to-many communication (e.g. 224.0.0.5)
- Local Broadcast: One to all local hosts (255.255.255.255)
- Directed Broadcast: One to all hosts in remote network (e.g. 172.20.255.255)
@ulend

+++
### Classes of IP Addresses
@ul
- Class A: First bit is `0` (Unicast /8)
- Class B: First bits are `10` (Unicast /16)
- Class C: First bits are `110` (Unicast /24)
- Class D: First bits are `1110` (Multicast)
- Class E: First bits are `1111` (Reserved)
@ulend

+++

### Routing basics
@ul
- IP and Mask of the interface show a network and all IP addresses in this network (`neighbors`)
- Communication with `neighbors` is `direct`
- Communication with others should be through a [default] `gateway` or `router`
- Cisco global configuration command is:
  - `ip default-gateway 172.16.1.1`
@ulend

+++

### IP Routing
@ul
- Routers can only reach known networks (present in `routing table` shown by `show ip route`)
  - If destination address of an incoming packet is not in the routing table, then the packet is dropped
- Sources of routing information:
  - Interfaces (`C` and `L` routes)
  - Static routes (`S`)
  - Dynamic routing (`R`, `D`, `O`, `B`, etc)
@ulend

Note:

Q: What do you have in your routing tables? What is the source of those routes?

+++

### Static routing
NetA --- `R1` --- NetB --- `R2` --- NetC --- `R3` --- NetD
@ul
- R1:
  - NetA, NetB - `C`
  - NetC, NetD - `?`
- R2: NetA - `?`, NetB - `C`, NetC - `C`, NetD - `?`
- R3: NetA - `?`, NetB - `?`, NetC - `C`, NetD - `C`
@ulend

+++

### Static routing
NetA --- `R1` --- NetB --- `R2` --- NetC --- `R3` --- NetD

@ul
- NetA - `192.168.1.0`; NetB - `192.168.12.0`
- NetC - `192.168.23.0`; NetD - `192.168.3.0`
- `R1(config)#ip route 192.168.23.0 255.255.255.0 192.168.12.2`
- `R1(config)#ip route 192.168.3.0 255.255.255.0 192.168.12.2`
@ulend

+++

### Static routing
```text
.1.0 -- R1 -- .12.0 -- R2 -- .23.0 -- R3 -- .3.0
R1:
ip route 192.168.23.0 255.255.255.0 192.168.12.2
ip route 192.168.3.0  255.255.255.0 192.168.12.2
R2:
ip route 192.168.1.0  255.255.255.0 192.168.12.1
ip route 192.168.3.0  255.255.255.0 192.168.23.3
R3:
ip route 192.168.1.0  255.255.255.0 192.168.23.3
ip route 192.168.12.0 255.255.255.0 192.168.23.3
```
@[1]
@[1-4]
@[1,5-7]
@[1,8-10]
@[1-10]

---

## Basics of L1, L2

+++

### Cables and connectors
@ul
- [Coaxial](https://en.wikipedia.org/wiki/Coaxial_cable)
- [Twisted pair](https://en.wikipedia.org/wiki/Twisted_pair)
- [Optical fiber cable](https://en.wikipedia.org/wiki/Optical_fiber_cable)
  - [Multi-mode fiber](https://en.wikipedia.org/wiki/Multi-mode_optical_fiber)
  - [Single-mode fiber](https://en.wikipedia.org/wiki/Single-mode_optical_fiber)
- [Twisted pair connectors](https://en.wikipedia.org/wiki/Modular_connector#8P8C)
  - [T568A/T568B](https://en.wikipedia.org/wiki/TIA/EIA-568#Wiring)
    - [Straight-through/crossover](https://en.wikipedia.org/wiki/Medium-dependent_interface)
- [Optical fiber connector](https://en.wikipedia.org/wiki/Optical_fiber_connector)
@ulend

+++

### Collisions and duplex
@ul
- Half-[duplex](https://en.wikipedia.org/wiki/Duplex_(telecommunications)) system - both parties can communicate with each other, but not simultaneously
  - If more than one party transmits at the same time - a collision occurs, resulting in lost messages
  - Carrier-sense multiple access with collision detection ([CSMA/CD](https://en.wikipedia.org/wiki/Carrier-sense_multiple_access_with_collision_detection))
- Full-duplex - no need for CSMA/CD
  - Duplex mismatch might cause late collisions
@ulend

+++

### Network types
@ul
- Point-to-point network
- Point-to-multipoint network
- Non-broadcast multiple-access network
- Broadcast network
  - [Ethernet hub](https://en.wikipedia.org/wiki/Ethernet_hub)
@ulend

+++

### [Power over Ethernet](https://en.wikipedia.org/wiki/Power_over_Ethernet)
@ul
- [PoE](https://en.wikipedia.org/wiki/Power_over_Ethernet#Standard_implementation) is used to pass electric power along with data on twisted pair Ethernet cabling
- Powered Device (PD) can provide it's class (0, 1, 2, 3, 4, etc) to Power Sourcing Equipment (PSE) for effective power allocation
- IEEE Stadards:
  - 802.3af-2003 - ≤ 15.4 W (PoE, Type 1)
  - 802.3at-2009 - ≤ 30.0 W (PoE+, Type 2)
  - 802.3bt-2018 - ≤ 60 or 100 W (Type 3, 4)
@ulend

+++

### Basics of wireless networks
@ul
- [IEEE 802.11](https://en.wikipedia.org/wiki/IEEE_802.11) - specifies WLAN implementations
- Each band (e.g. [2.4 GHz](https://en.wikipedia.org/wiki/List_of_WLAN_channels#2.4_GHz_(802.11b/g/n/ax)), [5 GHz](https://en.wikipedia.org/wiki/List_of_WLAN_channels#5_GHz_or_5.8_GHz_(802.11a/h/j/n/ac/ax))) has multiple [channels](https://en.wikipedia.org/wiki/List_of_WLAN_channels) - frequency slots, used by different Access Points (AP) in order not to interfere with each other
- 2.4 GHz signal travels further than 5 GHz and better propagates through obstacles
- 2.4 GHz band has more sources of noise (microwave ovens, wireless videocameras, headphones, etc)
@ulend

+++

### Wireless [Service Sets][SS]
@ul
- Service Set Identifier (SSID) - name of the wireless network
- Basic Service Set (BSS) - a group of stations that all share the same wireless channel, SSID, and other wireless settings
- BSSIDs (48-bit labels) identify devices within BSS
- Extended Service Set (ESS) - multiple BSSs on a common logical network segment
@ulend
[SS]: https://en.wikipedia.org/wiki/Service_set_(802.11_network)

+++

### [Wireless security][WiSec]
@ul
- Algorithms:
  - [WEP][WEP]
  - [WPA][WPA]
  - [WPA2][WPA2]
  - [WPA3][WPA3]
- Key management:
  - WPA-Personal
  - WPA-Enterprise
@ulend

[WiSec]: https://en.wikipedia.org/wiki/Wireless_security
[WEP]:   https://en.wikipedia.org/wiki/Wired_Equivalent_Privacy
[WPA]:   https://en.wikipedia.org/wiki/Wi-Fi_Protected_Access
[WPA2]:  https://en.wikipedia.org/wiki/WPA2
[WPA3]:  https://en.wikipedia.org/wiki/WPA3

+++

### Switch operation
@ul
- [Ethernet frame format](https://en.wikipedia.org/wiki/Ethernet_frame)
  - Preamble (7), Start frame delimiter (1),
  - Destintation MAC (6), Source MAC (6), Type(2),
  - Payload (46-1500), Frame check sequence (4),
  - Interpacket gap (12)
- MAC address table management
- Switching a frame
  - Flood
  - Forward
  - Filter
@ulend

+++

### Frame processing
@ul
- Frame processing
  - Store-and-forward
  - Cut-through
  - Fragment-free
- How to detect neighboring switches?
  - Cisco Discovery Protocol ([CDP][CDP])
  - Link Layer Discovery Protocol ([LLDP][LLDP])
@ulend
[CDP]: https://en.wikipedia.org/wiki/Cisco_Discovery_Protocol
[LLDP]: https://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol

+++

### Linking L2 and L3
@ul
- Address Resolution Protocol
  - Binds L3 and L2 addresses together
  - ARP request uses broadcast
  - ARP reply uses unicast
  - As well as broadcast (gratuitous ARP)
- Should ARP be sent to destination IP?
  - 172.16.1.5/24 -> 172.16.1.100
  - 192.168.232.215/24 -> 172.16.1.100
  - 192.168.232.215/24 -> 192.168.233.81
@ulend

---

## Internet Protocol

+++

### Subnetting
@ul
- A subnetwork or subnet is a part of an IP network
- `10101100.00010000.00000000.00000000`
- `nnnnnnnn.nnnnnnnn.hhhhhhhh.hhhhhhhh`
  - One network with 2^16 addresses
- `nnnnnnnn.nnnnnnnn.shhhhhhh.hhhhhhhh`
  - 2^1 subnets with 2^15 addresses per subnet
- `nnnnnnnn.nnnnnnnn.sssshhhh.hhhhhhhh`
  - 2^4 subnets with 2^12 addresses per subnet
@ulend

+++

### DHCP
@ul
- Dynamic Host Configuration Protocol
  - Client -> Server: Discover
  - Server -> Client: Offer
  - Client -> Server: Request
  - Server -> Client: Acknowledge
- Cisco DHCP Client
  - `Router(config-if)#ip address dhcp`
@ulend

+++

### Cisco DHCP Server and Relay
```text
ip dhcp excluded-address 172.16.1.1 172.16.1.20
ip dhcp pool POOL_NAME
 network 172.16.1.0 255.255.255.0
 default-router 172.16.1.1
 dns-server 172.16.1.5
 lease 0 10 0
! Binding the pool to an interface?
! What if there are 100 branches?
interface Gi0/0
 ip helper-address 172.30.1.6
```
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]
@[1-9]
@[1-10]

+++

### IPv6 Reasons
@ul
- IPv4 address shortage
  - Classless Inter-Domain Routing ([CIDR][CIDR])
  - Variable-length subnet masking ([VLSM][VLSM])
  - Network address translation ([NAT][NAT])
- Lessons, learnt from IPv4
  - No checksum
  - No fragmentation on routers
  - Easier address assignment
@ulend
[CIDR]: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
[VLSM]: https://en.wikipedia.org/wiki/Variable_length_subnet_mask
[NAT]: https://en.wikipedia.org/wiki/Network_address_translation

+++

### IPv6 Features
@ul
- IPv6 is a separate yet similar protocol
- IPv4 addresses use 32 bits (&asymp;4,2&times;10^9)
- IPv6 addresses use 128 bits (&asymp;3,4&times;10^38)
- Addresses are written in hexadecimal symbols
  - 128 bits per address
  - 32 symbols per address (4 bits per symbol)
  - 8 groups per address (4 symbols per group)
  - Groups are separated by colons
@ulend

+++

### IPv6 Addresses
@ul
- 0010000000000001 0000110110111000 0000000000000000 0000000000000000 0000000000000000 0000000000000000 0000000000000000 0000000000000001
- 2001:0db8:0000:0000:0000:0000:0000:0001
- 2001:db8:0:0:0:0:0:1
- 2001:db8::1
- 2001:1900:3001:0011:0000:0000:0000:002c
- 2001:1900:3001:11::2c
@ulend

+++

### IPv6 Address configuration
```text
interface GigabitEthernet0/1 ! mac aaaa.aabb.bbbb
 ipv6 enable
  !     fe80::a8aa:bbff:febb:bbbb
 ipv6 address 2001:db8::/64 eui-64
  ! 2001:db8::a8aa:bbff:febb:bbbb
 ipv6 address 2001:db8::1/64 ! 2001:db8::1
show ipv6 interface brief
 ! fe80::a8aa:bbff:febb:bbbb, 2001:db8::1,
 ! 2001:db8::a8aa:bbff:febb:bbbb
```
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]
@[1-9]

+++

### IPv6 Unicast Addresses
@ul
- Unicast:
  - Link-local address (fe80::/10) - can only be used on a single directly attached network (link)
  - Unique local address (fc00::/7) - routable only within private networks (no centralized registration)
  - Global unicast address (2000::/3) - globally administered, globally routable
@ulend

+++

### IPv6 Multicast Addresses
@ul
- Multicast (ff00::/8) - sending to a group of interested receivers
  - ff02::/8 - link-local scope
    - ff02::1 - all-nodes multicast (RA)
    - ff02::2 - all-routers multicast (RS)
    - ff02::1:ff00:0/104 - solicited-node multicast ([NDP][NDP])
      - ff02::1:ffbb:bbbb (MAC 33:33:ff:bb:bb:bb)
@ulend

[NDP]: https://en.wikipedia.org/wiki/Neighbor_Discovery_Protocol

+++

### Slide template
@ul[](false)
- Point
@ulend

