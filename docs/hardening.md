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


