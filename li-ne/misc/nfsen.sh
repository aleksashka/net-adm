#----------------------------------------

useradd netflow --shell=/bin/false --no-create-home
usermod -a -G apache netflow

#----------------------------------------

cd /usr/local/src/

wget https://github.com/phaag/nfdump/archive/v1.6.18.tar.gz
wget https://sourceforge.net/projects/nfsen/files/stable/nfsen-1.3.8/nfsen-1.3.8.tar.gz

tar xzf v1.6.18.tar.gz
tar xzf nfsen-1.3.8.tar.gz

#----------------------------------------

pushd nfdump-1.6.18
./autogen.sh
./configure --enable-sflow --enable-nfprofile --enable-nftrack --enable-readpcap
make
make install
popd

#----------------------------------------

chown -R root:root nfsen-1.3.8/
pushd nfsen-1.3.8/
cp etc/nfsen-dist.conf etc/nfsen.conf

sed -i -r \
-e "s|(.*(\$PERL_HAS_MEMLEAK=).*)|\1\n\21;|" \
-e "s|(.*'demoplugin'.*)|\1\n    [ '*',     'PortTracker' ],|" \
-e 's|^(\$BASEDIR\s*=\s*).*|\1"/opt/nfsen";|' \
-e 's|^(\$WWW.* = ).*|\1"apache";|' \
-e "s|.*peer1.*|    'ala-src'      => { 'port' => '9996', 'col' => '#ff0000', 'IP' => '192.168.1.1' },|" \
-e "s|.*peer2.*|    'ast-src'      => { 'port' => '9996', 'col' => '#00ff00', 'IP' => '192.168.1.2' },|" \
-e "s|(.*upstream1.*)|#\1|" \
etc/nfsen.conf

cp install.pl{,.orig}
cp libexec/NfProfile.pm{,.orig}
patch -b install.pl           /home/student/misc/install.pl.patch
patch -b libexec/NfProfile.pm /home/student/misc/NfProfile.pm.patch
./install.pl etc/nfsen.conf

cp /var/www/nfsen/details.php{,.orig}
# Add two scales and change default output to traffic (instead of flows)
sed -i -r \
-e "s|^(\\\$WinSizeScale.*\()|\1 0.0625, 0.125,|" \
-e "s|^(\\\$WinSizeLabels.*\()|\1 '3 hours', '6 hours',|" \
-e "s|(default.*array_key_exists.*detail_opts.*)flows|\1traffic|" \
/var/www/nfsen/details.php

cp /etc/php.ini{,.orig}
sed -i -r \
-e 's|(;date.timezone =.*)|\1\ndate.timezone = Asia/Almaty|' \
/etc/php.ini
popd

#----------------------------------------

cat >/etc/httpd/conf.d/nfsen.conf<<EOF
Alias /nfsen /var/www/nfsen
<Directory /var/www/nfsen>
    AllowOverride None
    DirectoryIndex nfsen.php
    #Require all granted
    Require host localhost
    Require ip 192.168.1.0/24
</Directory>
EOF

systemctl restart httpd

#----------------------------------------

cat > /etc/systemd/system/nfsen.service<<EOF
[Unit]
Description=NfSen Service
After=network.target

[Service]
Type=forking
PIDFile=/opt/nfsen/var/run/nfsend.pid
ExecStart=/opt/nfsen/bin/nfsen start
ExecStop=/opt/nfsen/bin/nfsen stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

systemctl enable nfsen
systemctl start nfsen

#----------------------------------------

cd /opt/nfsen/bin/
./nfsen --add-profile    "Ala" shadow=1
./nfsen --add-channel    "Ala/LAN"  sourcelist="ala-src" filter="dst net 192.168.2.0/24" colour=#00FF00 sign=+
./nfsen --add-channel    "Ala/WLAN" sourcelist="ala-src" filter="dst net 192.168.3.0/24" colour=#0000FF sign=+
./nfsen --commit-profile "Ala"

./nfsen --add-profile    "Ast" shadow=1
./nfsen --add-channel    "Ast/LAN"  sourcelist="ast-src" filter="dst net 192.168.4.0/24" colour=#00FF00 sign=+
./nfsen --add-channel    "Ast/WLAN" sourcelist="ast-src" filter="dst net 192.168.5.0/24" colour=#0000FF sign=+
./nfsen --commit-profile "Ast"

#----------------------------------------
