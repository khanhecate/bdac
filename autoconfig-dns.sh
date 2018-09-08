#!/bin/bash
echo "Wellcome to DNS auto Config (bind9) (Debian 8.6)."
echo "Starting ..."
sleep 3
echo "Ready , Ingin memnulai nya ?"
read -n1 -p "[ y , n ]" doit
case $doit in
	y|Y) echo "	    Installing bind9 ..." && apt install bind9 && echo "Done" ;;
	n|N) echo "		Arborting ..." && exit ;;
	*) echo "Pilihlah Y atau N" ;;
esac
echo -n "Nama Domain : "
read nd
echo -n "IP domain / IP yang akan dijadikan domain : "
read IPdn
echo -n "Nama Untuk file Forward nya : "
read Forward
echo -n "nama Untuk File Reverse nya : "
read Reverse
echo "Starting to Config zone "
sleep 4
echo -n "3 oktet IP Pertama Dibalik dari depan ke belakang : "
read tigaippertamax
echo -n "1 oktet IP Terahir : "
read zombloe

cp /etc/bind/db.127 db.$Reverse
cp /etc/bind/db.local db.$Forward
#File Named.conf.local (zone)
echo "
zone \"$nd\" {
        type master;
        file \"/etc/bind/db.$Forward\";
};
zone \"$tigaippertamax.in-addr.arpa\" {
        type master;
        file \"/etc/bind/db.$Reverse\";
};

" >> /etc/bind/named.conf.local
#file Forward DNS nya
echo ";
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     $nd. root.$nd. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $nd.
@       IN      A       $IPdn

" > /etc/bind/db.$Forward
#File Reverse
echo ";
; BIND reverse data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     $nd. root.$nd. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $dn.
$zombloe   IN      PTR     $IPdn.
" > /etc/bind/db.$Reverse

echo "Restarting BIND9 ..."
sleep 2
/etc/init.d/bind9 restart
echo "untuk mengecek konfigurasi ini anda bisa 
mengkonfigurasi file resolv.conf dan men nslookup nya 
atau anda bisa mengecek nya menggunakan komputer atau 
laptop client .
Trimakasi telah menggunakan Shell generate Beta saya
{\\_/}
('.')"