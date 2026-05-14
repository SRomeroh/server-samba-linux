# Hardening del servidor

## Firewall (UFW)
Se implementó UFW para gestionar el filtrado de paquetes. Se definió la politica deny incoming, allow outgoing de base permitiendo unicamente el trafico necesario para el funcionamiento del servidor.

* **Default Deny Incoming:** Bloquea los intento de conexión no autorizados hacía la VM.


* **Default Allow Outgoing:** Permite el trafico saliente desde la VM, necesario para que el sistema pueda descargar paquetes y actualizarse.


* **Allow ssh (22/tcp):** Permite la conexión de mi maquina host a la VM por SSH. **(Actualizado): Allow 2222/tcp"**
* **Modificación:** Se cambió el puerto SSH de 22 a 2222. Esto para evitar que herramientas automatizadas intenten ataques de fuerza bruta de manera sencilla. Esto mejoraría en menos cantidad de logs y meno uso de recursos en el caso de un ataque ya que habría menor cantidad de intentos de conexión. 

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


## Fail2BAN
Se implementó el servicio **Fail2ban** para prevenir ataques y acceso no autorizado al servidor. Además, al mitigar estos ataques también se reduce el consumo de recursos del servidor ya que al bloquear ips de atacantes el servidor no tiene que utilizar recursos para gestionar esas solicitudes.


* ** Config(sshd)**
Esta configuración se hizo, en primera instancia, en un archivo jail.conf

enable = true: Permite que las reglas definidas especificamente para [sshd] se apliquen.

port = 2222 - El puerto que asigné a el servicio sshd.

findtime = 10 : Indica el tiempo en el que se observara los intentos.

maxretry = 5: La cantidad de intentos permitidos que en conjunto con findtime revisan si se excedió.

bantime = 45m: Se le da un baneo a la ip de 45 Minutos antes que pueda intentar loguearse nuevamente

ignoreip = 10.0.2.2; la ip por la cual yo accede a la vm. Esto permite que por mas intentos fallidos que yo tenga no se me banea la ip.

Todos los logs por el momento van a /var/log/fail2ban.log
