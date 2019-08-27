## Environment

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

# Introduction to GNU/Linux

---

## Access

+++

### Console access

```text
centos-vm login: testuser
Password: PASSWORD
[testuser@centos-vm ~]$ exit
centos-vm login:


centos-vm login: root
Password: PASSWORD
[root@centos-vm ~]#
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

Command-line package-management utility
@ul[](false)
- Install, update, remove packages
- During the course we will need some additional packages
- Use `yum install packagename` to install packagename
    - `yum install traceroute`
- `yum install -y bash-completion vim wget mc tree man-pages`
@ulend

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
touch file1.txt file2.txt file3.txt
mkdir files backup tempdir
mv file1.txt file2.txt file3.txt files
cp files/file1.txt files/file2.txt files/file3.txt backup
cd files
cp file1.txt file2.txt file3.txt ../backup
rmdir files backup tempdir
cd ..
rmdir files backup tempdir
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
cat files.txt | grep 'ifcfg' | tee $(tty) | wc -l
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

+++

### Users and groups

```text
id
/etc/passwd; /etc/group
Switching users (su vs su -)
Superuser access (sudo)
# ls -l /home/alex/
drwxrwxr-x. 3 alex alex   21 Aug 14 09:48 github
-rw-rw-r--. 1 alex alex 1970 Aug 22 17:46 filename.txt
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
yum install https://centos7.iuscommunity.org/ius-release.rpm
yum install git2u
git init
git status
git add
git commit
git log
git diff
```

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
yum install certbot python2-certbot-apache
certbot -d www.example.com --agree-tos
    --email mail@example.com --no-eff-email
    -a webroot -w "/var/www/html/" -i apache

certbot certonly --preferred-challenges dns
    --manual --email mail@example.com
    --agree-tos --no-eff-email
    -d www.example.com
certbot install --apache
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
yum install named bind-utils
/etc/named.conf - main config file
```

+++

### Recursive DNS

```text
# /etc/named.conf
acl acl-trusted-ips { localhost; 10.0.2.0/24; };
acl acl-interfaces  { 127.0.0.1; 10.0.2.5   ; };
options {
    listen-on port 53 { acl-interfaces;  };
    allow-query       { acl-trusted-ips; }; };

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
    forwarders { 192.168.1.1; };
};
zone "1.168.192.in-addr.arpa" IN {
    type       forward;
    forwarders { 192.168.1.1; };
};

```

+++

### Response Policy Zone Config

```text
# Add to "options" of /etc/named.conf
response-policy { zone "rpz"; };

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
# Add to master zone
zone "alakin.org" {
    allow-transfer { 192.168.2.2; };
};
# Slave zone /etc/named/named.conf.local
zone "alakin.org" {
    type slave;
    masters { 192.168.1.1; };
    file "slaves/db.basu";
};
```

