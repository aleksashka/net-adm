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
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]

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
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]
@[1-9]
@[1-10]
@[1-11]

+++

### [Brace expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html)

```text
touch file{1,2,3,4,5,6,7,8,9}.txt
touch file{1..30}.txt
touch file{01..30}.txt
touch y{2019..2020}-m{01..12}.txt
```
@[1]
@[1-2]
@[1-3]
@[1-4]

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
@[1]
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]
@[1-7]
@[1-8]

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
