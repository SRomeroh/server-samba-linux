## Errores y soluciones.

* **Conflictos de permisos en /srv/**
* Problema: Acceso denegado /srv/samba
* Causa: Conflico de permisos entre el sistema y el servicio samba.
* Solución: Ajuste con chgrp smb_access y chmod 770 para asegurar que el demonio samba pueda leer el directorio correctamente.
