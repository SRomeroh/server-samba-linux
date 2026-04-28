# Hardening del servidor

## Firewall (UFW)
Se implementó UFW para gestionar el filtrado de paquetes. Se definió la politica deny incoming, allow outgoing de base permitiendo unicamente el trafico necesario para el funcionamiento del servidor.

* **Default Deny Incoming:** Bloquea los intento de conexión no autorizados hacía la VM.


* **Default Allow Outgoing:** Permite el trafico saliente desde la VM, necesario para que el sistema pueda descargar paquetes y actualizarse.


* **Allow ssh (22/tcp):** Permite la conexión de mi maquina host a la VM por SSH.


* **Allow Samba (445/tcp):** Opté por solo abrir el puerto 445 para el servicio samba y no el conjunto de puertos 137,139 para reducir la superficie de ataque y eliminar vulnerabilidades de protocolos heredados como NetBIOS.


## Actualizaciones
Se implementó unattended-upgrades para que se actualicen automaticamente solo los parches de seguridad.Esto reduce vulnerabilidades nuevas y no afecta a la estabilidad del sistema al no implementar mejoras de caracteristicas.


* **Origen:** Solo repositorio 'Debian-Security'.


* **Limpieza: ** Se habilitó autoremove de dependencias y kernels antiguos para optimizar el espacio en disco.


* **Verficación:** El estado se puede monitorear desde 'apt-daily-upgrade.timer'.


## Hardening Samba


* **[Config Global]**
disable_netbios = yes (Me aseguro que se desactive el protocolo netbios)
server min protocol = SMB3_11 (Me aseguro que se use el protocolo mas moderno de samba)
map to guest = never (No dejo que se acceda como usuario invitado/anonimo)
smb encrypt = required (Fuerzo a que la comunicación esté siempre encriptada)


* **Config [Compartido]** 
valid user = @smb_access (Restringo solo el acceso a aquellos usuarios que pertenezcan al grupo creado **smb_access**)
force group = smb_access (Fuerzo que el resto de operaciones hereden ese grupo)
**Los usuarios pertenecientes a ese grupo solo tienen permiso de lectura/escritura**

