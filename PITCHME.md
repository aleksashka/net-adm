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
@title[Intro]

# Introduction to Linux

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
- Enter IP address or hostname of linux machine
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
    - Ctrl+{a,e,u,k,p,n,r}
    - Esc+{.,b,f}
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
- `yum install -y bash-completion vim wget mc tree man`
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

### Managing files and directories

@ul[](false)
- `touch file1.txt file2.txt file3.txt`
- `mkdir files backup tempdir`
- `mv file1.txt file2.txt file3.txt files`
- `cp files/file1.txt files/file2.txt files/file3.txt backup`
- `cd files; cp file1.txt file2.txt file3.txt ../backup`
- `rmdir files backup tempdir`
- `cd ..; rmdir files backup tempdir`
- `rm -r files backup`
@ulend

---

## Bash intro

+++

### [Filename expansion](https://www.gnu.org/software/bash/manual/html_node/Filename-Expansion.html)

```text
touch zero one two three four five six seven
touch eight nine ten10 eleven11 twelve12
ls t*; ls n*; ls *n*; ls *n
ls ???; ls ????; ls ????*
ls [st]???*
ls *[[:digit:]]*
```
@[1-2]
@[1-3]
@[1-4]
@[1-5]
@[1-6]

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