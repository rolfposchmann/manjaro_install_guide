nano /etc/nsswitch.conf

# Commented out because of boot problems and NetworkManager failure
#passwd: files mymachines systemd
#group: files mymachines systemd
 
passwd: files mymachines
group: files mymachines


#fix network manager bug: https://forum.manjaro.org/t/every-other-reboot-i-have-no-networking-and-a-lot-of-unexpected-error-response-from-getnameowner/144416/10
systemctl disable org.cups.cupsd.service
systemctl enable org.cups.cupsd.socket

See https://github.com/systemd/systemd/issues/15316#issuecomment-667658293 2
