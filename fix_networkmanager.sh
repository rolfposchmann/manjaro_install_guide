nano /etc/nsswitch.conf

# Commented out because of boot problems and NetworkManager failure
#passwd: files mymachines systemd
#group: files mymachines systemd
 
passwd: files mymachines
group: files mymachines
