#!/usr/bin/env bash
MIB_DIR="/usr/share/snmp/cisco-mibs/"
if [ ! -d $MIB_DIR ]; then
    echo "Creating $MIB_DIR"
    mkdir $MIB_DIR
fi
for MIB in SNMPv2-SMI.my \
           SNMPv2-TC.my \
           CISCO-SMI.my \
           SNMPv2-CONF.my \
           CISCO-QOS-PIB-MIB.my \
           CISCO-MEMORY-POOL-MIB.my
do
    echo $MIB
    wget -q ftp://ftp.cisco.com/pub/mibs/v2/$MIB -O $MIB_DIR$MIB
    echo "mibs +$MIB_DIR$MIB" >> /etc/snmp/snmp.conf
done
