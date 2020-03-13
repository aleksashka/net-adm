# Basic Networking Course
Note:
vim: set syntax=markdown colorcolumn=49:

---

## Introduction

+++

### Network components
@ul[](false)
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
@ul[](false)
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
@ul[](false)
- #### Physical topologies
  - Bus
  - Star
  - Ring
  - Partial mesh
  - Full mesh
@ulend
@snapend
@snap[east]
@ul[](false)
- #### Logical topologies
  - Bus
  - Star
  - Ring
@ulend
@snapend
@snap[south]
@ul[](false)
- Reliability
- Availability
- Scalability
@ulend
@snapend

+++

### Network protocols
@ul[](false)
- Internet Protocol
- Ethernet
- Address Resolution Protocol
- Domain Name System
- Dynamic Host Configuration Protocol
- Open Shortest Path First
@ulend

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
@snapend

---

## Basics of IP

+++

### Conversion
@ul[](false)
- There are 10 types of people in the world. Those who understand binary and those who don’t.
- Counting from 0 to 100 in decimal
- Counting from 0 to 16 in binary
- Convert from binary to decimal
- Convert from decimal to binary
@ulend

+++

### IP, IP Address and Mask
@ul[](false)
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
@ul[](false)
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
@ul[](false)
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
@ul[](false)
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
@ul[](false)
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
@ul[](false)
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
```

+++

### Types of IP Addresses
@ul[](false)
- Localhost: Local communication only (127.0.0.0/8)
- Unicast: One-to-one communication (e.g. 10.1.1.1)
- Multicast: One-to-many communication (e.g. 224.0.0.5)
- Local Broadcast: One to all local hosts (255.255.255.255)
- Directed Broadcast: One to all hosts in remote network (e.g. 172.20.255.255)
@ulend

+++
### Classes of IP Addresses
@ul[](false)
- Class A: First bit is `0` (Unicast /8)
- Class B: First bits are `10` (Unicast /16)
- Class C: First bits are `110` (Unicast /24)
- Class D: First bits are `1110` (Multicast)
- Class E: First bits are `1111` (Reserved)
@ulend

+++

### Routing basics
@ul[](false)
- IP and Mask of the interface show a network and all IP addresses in this network (`neighbors`)
- Communication with `neighbors` is `direct`
- Communication with others should be through a [default] `gateway` or `router`
- Cisco global configuration command is:
  - `ip default-gateway 172.16.1.1`
@ulend

+++

### IP Routing
@ul[](false)
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
@ul[](false)
- R1:
  - NetA, NetB - `C`
  - NetC, NetD - `?`
- R2: NetA - `?`, NetB - `C`, NetC - `C`, NetD - `?`
- R3: NetA - `?`, NetB - `?`, NetC - `C`, NetD - `C`
@ulend

+++

### Static routing
NetA --- `R1` --- NetB --- `R2` --- NetC --- `R3` --- NetD

@ul[](false)
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

+++

### Slide template
@ul[](false)
- Point
@ulend

