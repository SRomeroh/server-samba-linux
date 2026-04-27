--Instalación y ejecución de la maquina virtual con QEMU/KVM--

Para comenzar creo el disco virtual que utilizaré con QEMU. Elijo del tipo QCOW2ya que es nativo de QEMU.

Ejecuto los siguientes comandos:
qemu-img create -f qcow2 debian-server.qcow2 20G
Esto crea el disco virtual "debian-server" con formato qcow2 con 20gb disponibles que se iran usando a medida que lo precise.

Lanzo por primera vez la maquina con estos comandos:
qemu-system-x86_64 \
-enable-kvm \ (Habilita KVM para que la virtualizacion se ejecute directamente en hardware)
-cpu host \
-m 2G \ (Le asigno inicialmente solo 2GB de memoria ram)
-smp 2 \ (Solo 2 nucleos del procesador)
-drive file=debian-server.qcow2,if=virtio,format=qcow2 \ (Selecciono el disco virtual que cree y lo establezco con el estandar virtio para que aplique las optmizaciones del mismo )
-netdev user,id=net0,hostfwd=tcp::2222-:22 \ (Selecciono la red y abro desde un primer momento los puertos 2222 de mi maquina y 22 (estandar ssh) del servidor.)
-device virtio-net-pci,netdev=net0 \
> -cdrom debian-13.4.0-amd64-netinst.iso \ (selecciono la iso)
> -boot d \ (booteo con la iso previamente seleccionada)
> -vga virtio \ (Especifica el estandar de la pantalla)
> -display gtk,zoom-to-fit=on. Luego de la instalación cambio a la opcion -display none. 

(Para proximos despliegues esto queda hecho un script automatizado en la seccion scripts/)

Particionamiento de debian:
/boot ext4 800MB
El resto se particionó con LVM que nos permitirá agregar y redimenzionar las particiones:
/ 5GB
/home 4GB LVM ext4
/var 5GB LVM ext4
/tmp 2GB LVM ext4
/swap 1GB LVM intercambio

No se instaló entorno grafico para reducir el consumo de recursos.

--Instalación Samba--

Instalo Samba.
'sudo apt install samba'

antes de configurar debo crear la carpeta donde se compartirán los recursos.
'mkdir -p /srv/samba/compartido'

debo configurar samba, edito el archivo /etc/samba/smb.conf // archivo completo en /configs/ //

seguido tengo que crear un usuario para poder autenticarme en samba:
uso sudo smbpasswd -a debianserver y luego introduzco una contraseña.
por ultimo reinicio el servicio con sudo /etc/init.d/smbd restart y ya puedo acceder al directorio compartido del servidor samba desde mi pc host conectandome a 127.0.0.1:4445 ( puerto especifico agregado para samba )


