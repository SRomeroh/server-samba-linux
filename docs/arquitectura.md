Una maquina virtual con QEMU y KVM.
Recursos de la VM(dinamicos):
-2 cpus
-2048mb de ram
-20GB Disco virtual qcow2.
-ssh desde el puerto 2222(Host) > ssh puerto 22 VM.

Los servicios que correrán inicialmente en el servidor son:
-Samba
-AppArmor
-ufw

Estos servicios se irán puliendo y modificando, posteriormente utilizaré Iptables/ Nftables asi como también servicios como fail2ban.
