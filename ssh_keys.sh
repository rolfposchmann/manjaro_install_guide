#!/bin/bash

ssh-keygen -p [-P old_passphrase] [-N new_passphrase] [-f keyfile]
ssh-keygen -f ~/.ssh/id_rsa -p

ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
ssh-keygen -f ~/tatu-key-ecdsa -t ecdsa -b 521


ssh-copy-id -i ~/.ssh/id_ed25519.pub -p 221 username@remote-server.org
-p is for PORT

#rolf
ssh-keygen -f ~/rolf-nag-key -t rsa -b 4096 -C "rolf@nag"
Optionen:
-m PEM = Formatieren des Schlüssels als PEM
-t rsa = Typ des zu erstellenden Schlüssels, in diesem Fall im RSA-Format
-b 4096 = die Anzahl der Bits im Schlüssel, in diesem Fall 4096
-C "rolf@nag" = ein Kommentar

#changing comment
ssh-keygen -c -C "my new comment" -f ~/.ssh/my_ssh_key

#creating pub key
ssh-keygen -l -f ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
