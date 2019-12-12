## Environment
Note:
vim: set syntax=markdown colorcolumn=49:

+++

### Installation

@ul[](false)
- [VirtualBox](https://virtualbox.org/)

- [CentOS](https://centos.org/)

    - Minimal install

- [PuTTY](https://www.putty.org/)

    - [Registry settings](https://github.com/aleksashka/random/blob/master/putty.md)
@ulend

+++

### CentOS: Prepare VM

@ul[](false)
- Create VM
    - Type: Linux
    - Version: Red Hat (64bit)
    - RAM: 2 GB
    - HDD: 50 GB
- Configure VM
    - Storage -> Optical Drive -> Choose ISO
    - Disable Audio
    - Network -> Adapter 1 -> Bridged Adapter
@ulend

+++

### CentOS: Install OS

@ul[](false)
- Choose "Install Centos"
    - Partitioning
    - Network adapter
    - Timezone
    - Root password
    - User account
    - Waiting for install
        - VirtualBox snapshots
        - PuTTY registry files
    - Reboot
@ulend

---

# Intro to GNU/Linux

---

## Access

+++

### Console access

```text
centos-vm login: testuser
Password: PASSWORD
[testuser@centos-vm ~]$ exit

centos-vm login: root
Password: PASSWORD
[root@centos-vm ~]#

# reboot
# poweroff
```

+++

### Remote access

@ul[](false)
- Run SSH-client (e.g. PuTTY)
- Enter IP address or hostname of the VM
- On connect enter `username` and `password`
@ulend

+++

### Bash

Bash (Bourne-Again SHell) - shell, or command language interpreter
@ul[](false)
- command [options] [arguments]
- `echo` - outputs the string, passed as an argument
    - `echo`
    - `echo test`
    - `echo -n test`
- `date` - displays current date and time
    - `date`
    - `date +%F`
@ulend

+++
@snap[north]
### Bash features
@snapend

@snap[west]
@ul[](false)
- History
- Command commenting
- Semicolon (;)
- Tab-completion
- Shortcuts
    - Ctrl+{f,b,e,a,w,u,k,y,p,n,r}
    - Esc+{f,b,.}
@ulend
@snapend

@snap[east]
@ul[](false)
- Some Bash commands
    - echo
    - pwd
    - cd [dir]
    - pushd
    - popd
    - dirs
@ulend
@snapend

+++

## yum

@ul[](false)
- Command-line package-management utility
- Install, update, remove packages
- Use `yum install PACKAGENAME` to install PACKAGENAME
    - `yum install traceroute`
- `yum search KEYWORD`
- Some packages: `bash-completion vim wget mc tree man-pages`
- `yum info bash-completion`
- `yum repolist`
@ulend

Note:

yum --disablerepo=updates repolist

---

## Filesystem

+++

### Filesystem Intro

@ul[](false)
- [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
- Absolute path
    - `cd /home/username/dir1`
    - `ls /etc/sysconfig/network-scripts/`
- Relative path
    - `cd dir1/`
    - `ls network-scripts`
- Navigation
    - `cd ..; cd -; pushd/popd/dirs`
@ulend

+++

### Searching files

@ul[](false)
- find
    - `find [path...] [expression]`
    - `find /etc/sysconfig/ -type d`
    - `find /etc/sysconfig/ -not -type f`
    - `find / -name '\*ifup\*'`
- locate
    - `yum install mlocate`
    - `updatedb`
    - `locate ifup`
@ulend

+++

### Viewing files

```text
cat /etc/os-release
cat /etc/services
wc -l /etc/services
less /etc/services
grep 53/udp /etc/services
grep ' 53/udp' /etc/services
```

+++

### Managing files

```text
touch f1.txt f2.txt f3.txt
mkdir files backup tempdir
mv f1.txt f2.txt f3.txt files
cp files/f1.txt files/f2.txt files/f3.txt backup
cd files; cp f1.txt f2.txt f3.txt ../backup
rmdir files backup tempdir
cd ..;  rmdir files backup tempdir
rm -r files backup
```

---

## Bash intro

+++

### [Filename expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html)

```text
touch zero one two three four five six seven
touch eight nine ten10 eleven11 twelve12
ls t*                ls n*
ls *n*               ls *n
ls ???
ls ????
ls ????*
ls [st]???*
ls *[[:digit:]]*
```

+++

### [Brace expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html)

```text
touch file{1,2,3,4,5,6,7,8,9}.txt
touch file{1..30}.txt
touch file{01..30}.txt
touch y{2019..2020}-m{01..12}.txt
```

+++

### [Command substitution](http://gnu.org/software/bash/manual/html_node/Command-Substitution.html)

```text
echo It is `date` now
echo It is $(date) now
TMPVAR=something
echo TMPVAR = $TMPVAR
echo TMPVAR =     $TMPVAR
echo "TMPVAR =     $TMPVAR"
echo "\$TMPVAR = $TMPVAR"
echo '\$TMPVAR = $TMPVAR'
```

+++

### Pipelines

```text
ls /usr/bin
ls /usr/bin | less
ls /usr/bin | wc -l
ls -1 /usr/bin | head -n 10
ls -1 /usr/bin > files.txt
ls -1 /usr/share > files.txt
ls -1 /usr/share >> files.txt
find /etc -name 'ifcfg*' > files.txt
find /etc -name 'ifcfg*' > files.txt 2> /dev/null
find /etc -name 'ifcfg*' > files.txt 2>&1
cat files.txt | grep 'ifcfg' | wc -l
cat files.txt | grep 'ifcfg' | tee f.txt | wc -l
```

---

## Vim, users, and permissions

+++

### Vim editor

```text
vimtutor [lang]
Modes: normal, insert, visual, command
Quitting Vim (:q, :wq, :q!, :qa)
Navigation (h, j, k, l, :[num])
Editing characters, words, lines (y, d, p, <, >)
Using tabs (:tabedit [filename], gt, gT,:qa)

background, number, relativenumber, autoindent,
expandtab, tabstop, softtabstop, shiftwidth
```

Note:

vimdiff?

+++

### Users and groups

```text
id
/etc/passwd; /etc/group
Switching users (su vs su -)
Superuser access (sudo)
# ls -l /home/alex/
drwxrwxr-x. 3 alex alex   21 Aug 14 09:48 dir
-rw-rw-r--. 1 alex alex 1970 Aug 22 17:46 f.txt
chown OWNER[:GROUP] FILE...
TODO: who can chown? root only
practice
```

Note:

man 5 passwd

man 5 group

primary group, secondary groups

su [-]: id, pwd, $PATH, $HOME

sudo command logs to /var/log/secure

+++

### Managing users and groups
```text
useradd
usermod
userdel
groupadd
groupmod
groupdel

TODO: Demo
```

+++

### File permissions, selinux

```text
rwxrwxrwx
Read, write, and execute bits
User, group, and others
uuugggooo
chmod MODE[,MODE] FILE...

getenforce
setenforce [Enforcing|Permissive|1|0]
/etc/selinux/config
TODO: Prepare easy to grasp examples
```

---

## Bash and Git

+++

### Bash scripting

```text
echo 'touch f01.txt' > my-script.sh
bash my-script.sh

echo '#!/usr/bin/env bash' >  my-script.sh
echo 'touch f01.txt'       >> my-script.sh
chmod +x my-script.sh
./my-script.sh
```

+++

### Running scripts automatically

```text
man 5 crontab
/etc/crontab
/etc/cron.d/
cat > /etc/cron.d/log-date-every-minute <<EOF
* * * * * root /bin/date >> /tmp/ldem.log
EOF
tail -f /tmp/ldem.log
```

Note:

Initially crontab, then cron.d directory

+++

### Git basics

```text
yum install https://centos7.iuscommunity.org/\
ius-release.rpm
yum install git2u
git init
git status
git add
git commit
git log
git diff
```

Note:

tune epel.repo

`time yum repolist --disablerepo="*" --enablerepo="epel"`

gpg --with-fingerprint FILENAME - to show fingerprint of key in FILENAME

---

# Linux for Network Admins

---

## IP, HTTP, tcpdump, firewalld

+++

### Static IP address
```text
# /etc/sysconfig/network-scripts/ifcfg-enp0s3
BOOTPROTO="none"
IPADDR=192.168.0.2
PREFIX=24
GATEWAY=192.168.0.1
DNS1=192.168.0.1
DNS2=8.8.8.8

systemctl restart network.service
```

+++

### HTTP Server

```text
yum install httpd
http://ip-address/
ss -tulpan | grep ':80'
systemctl status httpd
systemctl start httpd
systemctl enable httpd
tcpdump -i eth0 -nn tcp port 80
iptables -L -n -v
firewall-cmd --add-service=http
firewall-cmd --add-service=http --permanent
```

+++

### HTTPS Server

```text
yum install mod_ssl
systemctl reload httpd
firewall-cmd --add-service=https
```

+++

### Let's Encrypt

```text
yum install certbot python2-certbot-apache
certbot --domain www.example.com --agree-tos \
    --email mail@example.com --no-eff-email  \
    -a webroot -w '/var/www/html/' -i apache

certbot certonly --domain www.example.com \
    --manual --preferred-challenges dns

certbot install --apache
```

Note:

```
rsync -a -e "ssh -p2222" user@host:/root/git/letsencrypt/fake-only/ /etc/letsencrypt/
```

+++

### Renew certificates

```text
certbot renew    [--dry-run] [--noninteractive]
certbot certonly [--dry-run]
systemctl cat certbot-renew.service
systemctl enable certbot-renew.timer
```

---

## DNS Server

+++

### DNS Theory and Installation

```text
DNS Theory:
    - Zones (root, delegation)
    - Start from [a-l].root-servers.net
        - nslookup
        - dig
    - Recursion vs Forwarding
    - Master vs Slave
yum install bind bind-utils
/etc/named.conf - main config file
```

+++

### Recursive DNS

```text
# /etc/named.conf
acl acl-interfaces  { 127.0.0.1; 10.0.2.5   ; };
acl acl-trusted-ips { localhost; 10.0.2.0/24; };
options {
    listen-on port 53 { acl-interfaces;  };
    allow-query       { acl-trusted-ips; };
};

# named-checkconf
# named-checkzone ZONENAME ZONEFILE
```

+++

### Resource Records

@ul[](false)
- SOA - Start of authority for the zone
- NS - Nameserver for the zone
- A - Name to address mapping
- PTR - Address to name mapping
- CNAME - Canonical name (alias)
@ulend

+++

### SOA Timers

@ul[](false)
- `IN SOA nameserver email (serial refresh retry expire neg-ttl)`
- Serial - increases when content changes
- Refresh - how often should slave check master for changes
- Retry - how often to recheck if master is down
- Expire - if master is unavailable to expire interval, then slave should stop giving answers about the zone
- Negative caching TTL - TTL for all negative answers
@ulend

+++

### Authoritative DNS

```text
# Add to /etc/named.conf
include "/etc/named/named.conf.local";

# /etc/named/named.conf.local
zone "example.com" IN {
    type master;
    file "zones/db.example.com"; };
zone "2.0.10.in-addr.arpa" {
    type master;
    file "zones/db.10.0.2"; };
```

+++

### Authoritative DNS: Forward zone

```text
# /var/named/zones/db.example.com
$TTL  10800
@ IN SOA ns1.example.com. admin.example.com. (
           2019080100 10800 3600 604800 3600 )
@       IN      NS      ns1.example.com.
@       IN      NS      ns2.example.com.

ns1     IN      A       10.0.2.5
ns2     IN      A       10.0.2.6
pc1 30m IN      A       10.0.2.9
```

+++

### Authoritative DNS: Reverse zone

```text
# /var/named/zones/db.10.0.2
$TTL     3h
@    SOA ns1.example.com. admin.example.com. (
           2019080100    3h   1h     1w   1h )
                NS      ns1.example.com.
                NS      ns2.example.com.

5               PTR     ns1.example.com.
6               PTR     ns2.example.com.
9   30m         PTR     pc1.example.com.
```

+++

### Forwarding DNS

```text
# Add to /etc/named/named.conf.local
zone "alakin.org" IN {
    type       forward;
    forward    first;
    forwarders { 192.168.1.1; };
};
zone "1.168.192.in-addr.arpa" IN {
    type       forward;
    forward    only;
    forwarders { 192.168.1.1; };
};

```

+++

### Response Policy Zone Config

```text
# Add to "options" of /etc/named.conf
response-policy { zone "rpz"; }
    qname-wait-recurse no;

# Add to /etc/named/named.conf.local
zone "rpz" {
    type master;
    file "zones/db.rpz";
    allow-query { none; };
};
```

+++

### RPZ RRs

```text
# /var/named/zones/db.rpz
$TTL     1h
@ IN SOA ns1.example.com. admin.example.com. (
           2019080100    1h  15m     1w   1h )

ya.ru  A     192.168.1.1 ; Redirect to this IPv4
       AAAA  2001:DB8::1 ; and this IPv6
ip4.me CNAME .           ; NXDOMAIN
ip6.me CNAME *.          ; NODATA
```

+++

### Master and Slave Servers

```text
zone "alakin.org" { # Master zone config (1.1)
    allow-transfer { 192.168.2.2; };
};

zone "alakin.org" { # Slave zone config (2.2)
    type slave;
    masters { 192.168.1.1; };
    file "slaves/db.basu";
};
```

---

## Cacti

+++

### Installation and configuration
```text
yum install cacti mariadb-server php php-pear \
  php-bcmath php-mysqlnd
sed -i -r -e 's|(memory_limit).*|\1 = 800M|' -e \
  's|;(date.timezone).*|\0\n\1 = Asia/Almaty|'  \
  -e 's|(max_execution_time).*|\1 = 60|'        \
  /etc/php.ini
# Add cacti-config/my.cnf.d-server.cnf to:
/etc/my.cnf.d/server.cnf
systemctl enable mariadb
systemctl start  mariadb
```

Note:

```text
grep 'date.timezone' /etc/php.ini | grep       \
  '^[^;]' >/dev/null; if [ $? -eq 1 ]; then    \
  cp /etc/php.ini{,.orig}; sed -i -r -e        \
  's|;(date.timezone).*|\0\n\1 = Asia/Almaty|' \
  /etc/php.ini; fi
```

+++

### MariaDB and HTTP

```text
/usr/bin/mysql_secure_installation
mysql_tzinfo_to_sql /usr/share/zoneinfo | \
  mysql -u root -p mysql
mysql -u root -p
# Run commands from cacti-config/cacti-db.cnf
vim /etc/cacti/db.php # MariaDB user and pass
vim /etc/httpd/conf.d/cacti.conf # Access
systemctl reload httpd
# https://host.domain/cacti/
# Check /etc/cron.d/cacti
```

Note:

```
<Directory /usr/share/cacti/>
    <IfModule mod_authz_core.c>
        # httpd 2.4
        Require host localhost
        Require ip 10.2
```

+++

### SNMP
@ul[](false)
- [Simple Network Management Protocol](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)
- Management information base
- Messages:
  - GetRequest (.1.3.6.1.2.1.1.5.0)
  - GetResponse (STRING: alaGW.alakin.org)
- Versions: 1, 2c, 3
- snmpget, snmpwalk
- Adding MIBs
@ulend

Note:

snmpwalk -v2c -cCOMMUNITY ip.add.re.ss .1.3.6.1.4.1.9.9.48.1.1.1

./cisco-memory-mib.sh

snmpwalk -v2c -cCOMMUNITY ip.add.re.ss .1.3.6.1.4.1.9.9.48.1.1.1

+++

### Monitoring network devices

@ul[](false)
- Add device (Create > New Device)
  - Hostname
  - Device Template
  - SNMP Version and Community
- Add graph (Create > New Graphs)
  - Choose device
  - Data Query > Select a Graph Type
    - In/Out Bits (64-bit, BW)
    - In/Out (Errors/Discards)
@ulend

+++

### Working with graphs

@ul[](false)
- Sites
- Trees
- Real-time Graphs (Configuration > Settings)
  - Visual > Real-time Graphs
    - Graph Timespan
    - Refresh Interval
    - Logout/Login and check
@ulend

+++

### Sending emails

@ul[](false)
- Console > Configuration > Settings > Mail/Reporting/DNS
  - Server Base URL
  - Test Email
  - Mail Services = SMTP:
    - Hostname = smtp.gmail.com
    - Port = 587
    - Username/Password
    - Security = TLS
  - Send a Test Email
@ulend

Note: Elaborate on which password should be used

Base URL should be without slash at the end

+++

### Reporting (Nectar Plugin)

@ul[](false)
- Reporting > Add
  - Next Timestamp for Sending Mail Report
  - Report Interval
  - To Email Address(es)
- Items > Add
  - Text / Graph / Horizontal Rule
- Preview
- Events
@ulend

+++

### Thold Plugin

@ul[](false)
- Download from github.com/Cacti/plugin_thold
- Unpack to /usr/share/cacti/plugins/thold
- Cacti > Console > Configuration
  - Plugins
    - Install Thold
    - Enable Thold
  - Settings > Alerting/Thold
    - Dead Device Notifications Email
- Console > Management > Thresholds > Add
@ulend

+++

### Templating Uptime Notifications

@ul[](false)
- Console > Templates > Threshold > Add
  - Persistent Acknowledgment
  - Re-Alert Cycle: Every Day
  - Alert Low Threshold: 8640000
- Manually create threshold from template:
  - Management > Thresholds > Add
    - Threshold Template
    - Select threshold template
    - Select graph template
    - Select device to apply threshold
@ulend

+++

### Automating thresholds

@ul[](false)
- Associate threshold template with device template:
  - Templates > Device > Select device template:
    - Associated Threshold Templates
      - Add Threshold Template
- Apply multiple thresholds to multiple devices:
  - Management > Devices > Select devices > Apply Thresholds > Go
- Auto apply thresholds on creation:
  - Configuration > Settings > Alerting/Thold
    - Auto Create Thresholds > Yes
@ulend

+++

### Syslog plugin installation

@ul[](false)
- install `rsyslog-mysql`
- Download from github.com/Cacti/plugin_syslog
- Unpack to /usr/share/cacti/plugins/syslog
- `cp config.php.dist config.php`
- edit `config.php`
- Cacti > Console > Configuration > Plugins
  - Install Syslog
  - Enable Syslog
@ulend

+++

### Syslog configuration

```text
# copy cacti-config/rsyslog.d-cacti.conf to
# /etc/rsyslog.d/cacti.conf
systemctl restart rsyslog

# Tune /etc/rsyslog.d/cacti.conf if needed
# Do not send local logs to database
if $fromhost-ip<>'127.0.0.1' then \
:ommysql:localhost,db,user,pass;cacti_syslog
# Stop processing these logs by rsyslog rules
& stop
```

Note:

[Logs flooded with systemd messages](https://access.redhat.com/solutions/1564823)

Start filename.conf with zero, to make sure it is read first

logger --udp --server 192.168.100.20 -- "Log message from 192.168.100.2"

mysql -u root -p

show databases;

use cacti;

show tables;

show columns from syslog;

select &ast; from syslog;

select &ast; from syslog where message like '%2020%';

select host_id, logtime, message from syslog where message like '%2020%';

select host_id, logtime, message from syslog where host_id <> '1';

select host_id, logtime, substring(message,1,50) from syslog where host_id <> '1';

show tables;

select * from syslog_hosts;

select syslog_hosts.host, logtime, substring(message,1,50) from syslog inner join syslog_hosts ON syslog.host_id=syslog_hosts.host_id where syslog.host_id<>'1';

Bug [#369](https://github.com/Cacti/plugin_thold/issues/369) in thold 1.3.2

select id, name_cache, notify_extra from thold_data;

update thold_data set notify_extra='alakinalexandr+fake.cacti@gmail.com' where id='2';

select id, name_cache, notify_extra from thold_data;

+++

### Syslog plugin alerts

@ul[](false)
- Console > Syslog Settings
  - Alert Rules - send email upon receiving specific syslog message
  - Removal Rules - remove unwanted messages
  - Report Rules - send periodic emails with a list of specific messages
@ulend

---

## nfsen

+++

### Overview

@ul[](false)
- [nfdump](http://nfdump.sourceforge.net/) - netflow display and analyze program
- [nfsen](http://nfsen.sourceforge.net/) - graphical web based front end for the nfdump netflow tools
- [plugins](https://github.com/mdjunior/nfsen-plugins)
- [Install guide 1](https://github.com/paidegua/nfsen_on_centos7)
- [Install guide 2](https://wiki.polaire.nl/doku.php?id=nfsen_centos7)
@ulend

+++

### Installation

```text
cd /usr/local/src/
# https://github.com/phaag/nfdump/
# https://sourceforge.net/projects/nfsen/

yum install doxygen rrdtool-perl rrdtool-devel \
  flow-tools-devel bzip2-devel perl-Sys-Syslog \
  libpcap-devel flex libtool flow-tools byacc  \
  perl-Socket6 perl-MIME-tools perl-MailTools

# check and run misc/nfsen.sh
```

+++

### Configuration

```text
# last section of misc/nfsen.sh
cd /opt/nfsen/bin/; ./nfsen --help
./nfsen --add-profile "Ala" shadow=1

./nfsen --add-channel "Ala/LAN"     \
  filter="dst net 192.168.2.0/24"   \
  sourcelist="ala-src" colour=#00FF00

./nfsen --add-channel "Ala/WLAN"    \
  filter="dst net 192.168.3.0/24"   \
  sourcelist="ala-src" colour=#0000FF

./nfsen --commit-profile "Ala"
```

+++

### Exporting flows from Cisco

[Cisco IOS NetFlow Configuration (Release 15M&T)](https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/netflow/configuration/15-mt/nf-15-mt-book/get-start-cfg-nflow.html)
```text
configure terminal
ip flow-export version 9
ip flow-export destination 192.168.0.1 9996
interface FastEthernet0
 ip flow ingress
 ip flow egress
end

# samplicator to duplicate UDP datagrams
```

Note:

wget https://github.com/sleinen/samplicator/releases/download/v1.3.6/samplicator-1.3.6.tar.gz

tar xzf samplicator-1.3.6.tar.gz

chown -R root: samplicator-1.3.6

cd samplicator-1.3.6

./configure

make

make install

samplicate -p 9995 -S 192.168.100.20/9996 192.168.100.24/9996 192.168.100.2/9996

samplicate -d 1 -p 9995 -S 192.168.100.20/9996 192.168.100.24/9996 192.168.100.2/9996
