## Errores y soluciones.

* **Conflictos de permisos en /srv/**
* Problema: Acceso denegado /srv/samba
* Causa: Conflico de permisos entre el sistema y el servicio samba.
* Solución: Ajuste con chgrp smb_access y chmod 770 para asegurar que el demonio samba pueda leer el directorio correctamente.


## Conflicto de puertos ssh
* Problema: Connection refused / Connection closed en el puerto 2222 con ssh desde mi terminal host.
* Causa: Existía un mapeo de puertos en el archivo de lanzamiento/configuración de la VM que redirigía el puerto 2222 del host al 22 de la VM. Al cambiar el puerto interno de SSH en la VM a 2222, la redirección fallaba porque el tráfico seguía buscando el puerto 22 dentro del servidor en la VM.
* Solución: Se sincronizaron ambos extremos. Se modificó la configuración de la VM para que el tráfico del puerto 2222 del host se redirija al puerto 2222 de la VM, coincidiendo con la nueva configuración de sshd_config y las reglas de UFW.
* Comando en cuestión: **-netdev user,id=net0,hostfwd=tcp::2222-:2222,hostfwd=tcp::4445-:445 \**
